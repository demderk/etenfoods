//
//  StepsModel.swift
//  eten
//
//  Created by Roman Zheglov on 04.10.2022.
//

import Foundation
import HealthKit

class StepsModel {
    
    typealias DataUpdated = (StepsData) -> Void
    
    private var healthStore: HKHealthStore?
    
    private(set) var stepsData: StepsData = StepsData()
    
    private(set) var lastError: Error?
    
    private var listenerCollection: [DataUpdated] = []
    
    init() {
        if (HKHealthStore.isHealthDataAvailable()) {
            healthStore = HKHealthStore()
            requestAutorization() {
                done in
            }
            updateCurrentSteps()
        }
    }
    
    func requestAutorization(completion: @escaping (Bool) -> Void) {
        let stepType = HKQuantityType(.stepCount)
        
        guard let healthStore = self.healthStore else { return completion(false) }
        
        healthStore.requestAuthorization(toShare: [], read: [stepType], completion: { (done, err) in
            completion(done)
        })
    }
    
    func updateCurrentSteps() {
        let stepType = HKQuantityType(.stepCount)
        
        let startFrom = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        
        let anchorDate = Calendar.init(identifier: .iso8601).date(from: Calendar.current.dateComponents([.day, .hour, .weekOfYear, .month], from: Date()))!
        
        
        let predicate = HKQuery.predicateForSamples(withStart: startFrom, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: .init(day: 1))
        
        query.initialResultsHandler = {(_, stats: HKStatisticsCollection?, err: Error?) in
            stats?.enumerateStatistics(from: startFrom!, to: Date()) {
                (stats: HKStatistics, _) in
                if let data = stats.sumQuantity() {
                    self.stepsData.steps += Int(data.doubleValue(for: .count()))
                }
                self.dataUpdated()
            }
        }
        
        if let healthStore = self.healthStore {
            healthStore.execute(query)
        }
    }
    
    func onDataUpdated(function: @escaping DataUpdated) {
        listenerCollection.append(function)
    }
    
    private func dataUpdated() {
        for item in listenerCollection {
            item(self.stepsData)
        }
    }
}
