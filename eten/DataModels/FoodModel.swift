//
//  FoodModel.swift
//  eten
//
//  Created by Roman Zheglov on 24.12.2022.
//

import Foundation

class FoodModel: Identifiable {
    var id = UUID()
    
    var name = "Unnamed"
    var description = "No description"
    var carbs: Double = 0
    var protein: Double = 0
    var fats: Double = 0
    var calories: Int = 0
    var portion: Int = 0
}
