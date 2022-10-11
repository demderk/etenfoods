//
//  ErrorCard.swift
//  eten
//
//  Created by Roman Zheglov on 12.10.2022.
//

import Foundation
import SwiftUI

struct ErrorCard: View {
    var title = "Error"
    var description = "Error message"
    
    init(title t: String, description d: String) {
        title = t
        description = d
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Spacer().frame(height: 4)
            HStack {
                Spacer().frame(width: 16)
                Image(systemName: "xmark.circle")
                Spacer().frame(width: 4)
                Text(title)
                Spacer().frame(width: 16)
            }.font(.callout.weight(.medium))
                .foregroundColor(Color("ErrorRed"))
            HStack {
                Spacer().frame(width: 16)
                Text(description)
                    .font(.secondary)
                    .foregroundColor(Color("ErrorRed"))
                    .lineLimit(2)
                Spacer().frame(width: 16)

            }
            Spacer().frame(height: 4)
        }.frame(width: 320, height: 88, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 8).fill(Color.init(hue: 0.03, saturation: 0.22, brightness: 1, opacity: 0.2))
            }
    }
}
