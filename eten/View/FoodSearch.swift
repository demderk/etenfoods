//
//  FoodSearch.swift
//  eten
//
//  Created by Roman Zheglov on 01.01.2023.
//

import Foundation
import SwiftUI


struct FoodSearchView: View {
    @Binding var searchIslandOpacity: Double
    @Binding var searchText: String
    @Binding var searchIslandOffset: Double
    
    @FocusState private var IsOpened: Bool
    
    @State var isDragEnabled = false
    @State var animationLastLocation : Double? = nil
    
    @State var maxOffsetHeight = -1000.0
    
    var searchStateChanged: () -> Void = {}
    
    var body: some View {
        VStack {
            if (!isDragEnabled) {
                Spacer()
            }
            ZStack {
                VStack{
                    Spacer().frame(maxHeight: 16)
                    HStack {
                        NavigationLink(destination: { Text("NYI") }) {
                            //FIXME: CHANGE BUTTON PATH HERE
                            VStack{
                                Image(systemName: "plus")
                                Spacer().frame(height: 4)
                                Text("Create Meal").font(.caption)
                            }.padding(.horizontal,16)
                                .frame(height: 56, alignment: .center)
                                .background(.white)
                                .cornerRadius(8)
                        }.buttonStyle(.plain)
                        Spacer().frame(width: 16)
                        NavigationLink(destination: { Text("NYI") }) {
                            //FIXME: CHANGE BUTTON PATH HERE
                            VStack{
                                Image(systemName: "barcode.viewfinder")
                                Spacer().frame(height: 4)
                                Text("Scan Barcode").font(.caption)
                            }.padding(.horizontal,16)
                                .frame(height: 56, alignment: .center)
                                .background(.white)
                                .cornerRadius(8)
                        }.buttonStyle(.plain)
                        Spacer().frame(width: 16)
                        NavigationLink(destination: { Text("NYI") }) {
                            //FIXME: CHANGE BUTTON PATH HERE
                            VStack{
                                Image(systemName: "bolt.fill")
                                Spacer().frame(height: 4)
                                Text("Quick Add").font(.caption)
                            }.padding(.horizontal,16)
                                .frame(height: 56, alignment: .center)
                                .background(.white)
                                .cornerRadius(8)
                        }.buttonStyle(.plain)
                    }
                    Spacer().frame(height: 16)
                    ZStack{
                        if (!IsOpened){
                            HStack(alignment: .center) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.secondary)
                                Spacer()
                            }.padding(.horizontal, 8)
                        }
                        TextField("Search over Eten Foods", text: $searchText)
                            .fixedSize(horizontal: !IsOpened, vertical: false)
                            .focused($IsOpened, equals: true)
                            .multilineTextAlignment(IsOpened ? .leading : .center)
                            .padding(.horizontal, 8)
                            .onChange(of: IsOpened){ _ in
                                //                                searchStateChanged()
                            }
                    }.frame(height: 44)
                        .padding(.horizontal,8)
                        .background(.white)
                        .cornerRadius(16)
                        .padding(.horizontal, 16)
                    Spacer().frame(minHeight: 54)
                }.opacity(searchIslandOpacity)
                    .frame(maxWidth: .infinity, maxHeight: 144 + 54 + searchIslandOffset * -1)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16, corners: [.topLeft,.topRight])
                    .offset(y: 54)
//                    .animation(.easeOut(duration: 0.250))

            }.gesture(
                DragGesture(minimumDistance: 10, coordinateSpace: .global)
                    .onChanged{ changed in
                        DispatchQueue.main.async {
                            if (changed.translation.height > 0) {
                                searchIslandOffset = maxOffsetHeight + changed.translation.height
                            }
                            else {
                                searchIslandOffset = changed.translation.height
                            }
                            print("\(changed.predictedEndTranslation.height) | \(changed.translation.height) | \(searchIslandOffset) | \(animationLastLocation)")
                        }
                    }
                    .onEnded{ ended in
                        if (ended.translation.height < 0) {
                            if (ended.translation.height < -100) {
                                withAnimation(.spring()){
                                    searchIslandOffset = maxOffsetHeight
                                }
//                                animationLastLocation = nil
                            }
                            else {
                                withAnimation(.spring()){
                                    searchIslandOffset = 0
                                }
//                                animationLastLocation = nil
                            }
                        }
                        else {
                            if(ended.translation.height >= 20)
                            {
                                withAnimation(.spring()){
                                    searchIslandOffset = 0
                                }
//                                animationLastLocation = nil
                            }
                            else {
                                withAnimation(.spring()){
                                    searchIslandOffset = maxOffsetHeight
                                }
//                                animationLastLocation = nil
                            }
                        }
                        
                        print("–––––––––––––––––")
                        print("\(ended.translation.height)")
                        print("–––––––––––––––––")
//                        isDragEnabled = false
                    }
            )
            // See UI/Extensions/cornerRadiusCustom
        }
    }
}
