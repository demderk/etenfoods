//
//  CardProgressStyle.swift
//  eten
//
//  Created by Roman Zheglov on 24.09.2022.
//

import Foundation
import SwiftUI

struct CardProgressStyle: ProgressViewStyle {
    var color = Color.blue
    var width: CGFloat = 344
    
    
    func makeBody(configuration: Configuration) -> some View {
        let currntProgress: CGFloat = Double(width) * (configuration.fractionCompleted ?? 0)
        
        return ZStack(alignment: .leading){
            Rectangle()
                .fill(Color.init(hue: 0, saturation: 0, brightness: 0.96))
                .cornerRadius(4)
                .frame(width: width, height: 8)
            Rectangle()
                .fill(color)
                .cornerRadius(4)
                .frame(width: currntProgress, height: 8)
        }
        
    }
}
