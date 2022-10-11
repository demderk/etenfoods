//
//  CaloriesCard.swift
//  eten
//
//  Created by Roman Zheglov on 03.10.2022.
//

import Foundation
import SwiftUI

struct StepsCard: View {
    
    var stepsData: StepsData
    
    var caloriesProgress: Double {
        min(Double(stepsData.stepsGoal)/Double(stepsData.steps), 1)
    }
    
    var stepsToGo: Int {
        stepsData.stepsGoal - stepsData.steps
    }
    
    var progressBarColor: Color {
        caloriesProgress >= 1 ? .blue : .blue
    }
    
    var body: some View {
        VStack() {
            Spacer()
                .frame(height: 16.0)
            HStack() {
                Image(systemName: "figure.walk")
                    .foregroundColor(.blue)
                Text("Steps")
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(.blue)
                Spacer()
            }.font(.body)
                .padding(.leading, 16)
            
            Spacer()
                .frame(height: 8)
            
            HStack(alignment: .lastTextBaseline) {
                Spacer()
                    .frame(width: 16.0)
                Text("\(stepsData.steps)")
                    .font(.title)
                Spacer()
                    .frame(width: 4.0)
                Text("steps")
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
                Text("\(stepsData.stepsGoal) is goal")
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("\(stepsToGo) to go")
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
