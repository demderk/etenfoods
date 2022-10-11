//
//  CaloriesCardVM.swift
//  eten
//
//  Created by Roman Zheglov on 03.10.2022.
//

import Foundation
import SwiftUI

class MainPageVM: ObservableObject {
    @Published var caloriesData: CaloriesData
    @Published var stepsData: StepsData = StepsData()
    
    var stepsModel: StepsModel = StepsModel()
    
    init() {
        caloriesData = CaloriesData(caloriesCount: 600, caloriesMax: 1200, caloriesBurned: 600, caloriesArrowIsUp: true)
        stepsData = stepsModel.stepsData
    }
    
    
    
    func caloriesPush(count: Int) {
        caloriesData.caloriesCount += 100
        stepsData.steps += 100
    }
    
    
}
