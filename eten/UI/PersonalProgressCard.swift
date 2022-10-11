//
//  PersonalProgressCard.swift
//  eten
//
//  Created by Roman Zheglov on 24.09.2022.
//

import Foundation
import SwiftUI

struct PersonalProgressCard: View {
    var body: some View {
        NavigationLink(destination: { Text("NYI") }) {
            VStack() {
                HStack() {
                    Image(systemName: "arrow.up.heart.fill")
                    Text("Personal Progress")
                        .bold()
                    Spacer()
                }.font(.body)
                    .padding(.top, 16)
                    .padding(.leading, 16)
                    .foregroundColor(.green)
                Spacer().frame(height: 12)
                HStack() {
                    Spacer().frame(width: 32)
                    VStack(alignment: .center) {
                        Text("10")
                            .bold()
                            .foregroundColor(.black)
                        Text("Progress Points")
                            .font(.caption)
                            .foregroundColor(.init(hue: 0, saturation: 0, brightness: 0.60))
                    }
                    Spacer()
                    VStack(alignment: .center) {
                        Text("3")
                            .bold()
                            .foregroundColor(.black)
                        Text("Days on fire").font(.caption)
                            .font(.caption)
                            .foregroundColor(.init(hue: 0, saturation: 0, brightness: 0.60))
                    }
                    Spacer()
                    VStack(alignment: .center) {
                        Text("10")
                            .bold()
                            .foregroundColor(.black)
                        Text("Progress Points").font(.caption)
                            .font(.caption)
                            .foregroundColor(.init(hue: 0, saturation: 0, brightness: 0.60))
                    }
                    Spacer()
                }
                Spacer()
                    .frame(height: 13)
                ProgressView(value: 0.60)
                    .progressViewStyle(CardProgressStyle(color: Color(cgColor: UIColor.systemGreen.cgColor), width: 312))
                    .padding(.leading, 0)
                Spacer()
            }.frame(width: 344, height: 128)
                .background(.white)
                .cornerRadius(8)
                .contentShape(Rectangle())
        }.buttonStyle(.plain)
    }
}
