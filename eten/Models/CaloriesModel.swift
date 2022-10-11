//
//  CaloriesModel.swift
//  eten
//
//  Created by Roman Zheglov on 03.10.2022.
//

import Foundation

class CaloriesModel {
    public var caloriesData = CaloriesData()
    
    init() {
        GetCalories()
    }
    
    func GetCalories() {
        caloriesData = CaloriesData(caloriesCount: 600, caloriesMax: 1200, caloriesArrowIsUp: true)
    }
}
