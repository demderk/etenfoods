//
//  DayInfoCard.swift
//  eten
//
//  Created by Roman Zheglov on 24.09.2022.
//

import Foundation
import SwiftUI

struct DayInfoCard: View {
    @State public var stepsCount = 10000
    @State public var stepsMax = 5608
    @State public var stepsProgress = 0.6
    @State public var stepsArrowIsUp = true
    @State public var caloriesCount = 2190
    @State public var caloriesMax = 2600
    @State public var caloriesProgress = 0.8
    @State public var caloriesArrowIsUp = false
    
    // make private
    
    var body: some View {
        VStack() {
            HStack() {
                Image(systemName: "flame.fill")
                    .foregroundColor(Color("CaloriesColor"))
                Text("Total Calories")
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(Color("CaloriesColor"))
                Spacer()
                Group {
                    Text("\(caloriesCount) of \(caloriesMax)")
                    Image(systemName: caloriesArrowIsUp ? "arrow.up" : "arrow.down")
                        .font(.caption)
                }.foregroundColor(.gray)
                Spacer()
                    .frame(width: 16.0)
            }.font(.body)
                .padding(.top, 16)
                .padding(.leading, 16)
            ProgressView(value: caloriesProgress)
                .progressViewStyle(CardProgressStyle(color: Color("CaloriesColor"), width: 312))
                .padding(.leading, 0)
            Spacer()
                .frame(width: 16.0)
            HStack() {
                Image(systemName: "figure.walk")
                    .foregroundColor(.blue)
                Text("Steps")
                    .bold()
                    .lineLimit(1)
                    .foregroundColor(.blue)
                Spacer()
                Group {
                    Text("\(stepsCount) of \(stepsMax)")
                    Image(systemName: stepsArrowIsUp ? "arrow.up" : "arrow.down")
                        .font(.caption)
                }.foregroundColor(.gray)
                Spacer()
                    .frame(width: 16.0)
            }.font(.body)
                .padding(.leading, 16)
            ProgressView(value: stepsProgress)
                .progressViewStyle(CardProgressStyle(color: Color(cgColor: UIColor.systemBlue.cgColor), width: 312))
                .padding(.leading, 0)
            Spacer()
                .frame(width: 8.0)
        }.frame(width: 344, height: 144)
            .background(.white)
            .cornerRadius(8)
    }
    
}
