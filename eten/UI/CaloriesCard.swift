//
//  CaloriesCard.swift
//  eten
//
//  Created by Roman Zheglov on 03.10.2022.
//

import Foundation
import SwiftUI

struct CaloriesCard: View {
    
    var caloriesData: CaloriesData
    
    var caloriesLeft: Int {
        (caloriesData.caloriesMax + caloriesData.caloriesBurned) - caloriesData.caloriesCount
    }
    
    var caloriesProgress: Double {
        min(Double(caloriesData.caloriesCount) / Double(caloriesData.caloriesMax + caloriesData.caloriesBurned), 1)
    }
    
    var progressBarColor: Color {
        caloriesProgress >= 1 ? .black : Color("CaloriesColor")
    }
    
    var body: some View {
        VStack() {
            Spacer()
                .frame(height: 16.0)
            HStack() {
                Image(systemName: "flame.fill")
                    .foregroundColor(Color("CaloriesColor"))
                Text("Calories Left")
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(Color("CaloriesColor"))
                Spacer()
            }.font(.body)
                .padding(.leading, 16)
            
            Spacer()
                .frame(height: 8)
            
            HStack(alignment: .lastTextBaseline) {
                Spacer()
                    .frame(width: 16.0)
                Text("\(caloriesLeft)")
                    .font(.title)
                Spacer()
                    .frame(width: 4.0)
                Text("kcal")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                    
                Spacer()
            }
            
            Spacer()
                .frame(height: 8.0)
            
            ProgressView(value: caloriesProgress)
                .progressViewStyle(CardProgressStyle(color: progressBarColor, width: 312))
                .padding(.leading, 0)
            
            Spacer()
                .frame(height: 4.0)
            
            HStack {
                Spacer()
                    .frame(width: 16.0)
                Text("\(caloriesData.caloriesCount) of \(caloriesData.caloriesMax + caloriesData.caloriesBurned)")
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("\(caloriesData.caloriesBurned) burned")
                    .multilineTextAlignment(.trailing)
                Spacer()
                    .frame(width: 16.0)
            }.font(.system(size: 13))
                .foregroundColor(.gray)
            
            Spacer()
            
        }.frame(width: 344, height: 136)
            .background(.white)
            .cornerRadius(8)
    }
}
