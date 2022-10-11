//
//  ContentView.swift
//  eten
//
//  Created by Roman Zheglov on 24.07.2022.
//

import SwiftUI
import CoreGraphics

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RouterView()
                .previewDevice("iPhone 8")
        }
    }
}
