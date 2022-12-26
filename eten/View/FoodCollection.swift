//
//  FoodCollection.swift
//  eten
//
//  Created by Roman Zheglov on 24.12.2022.
//

import SwiftUI

struct FoodCollection: View {
    var foodCollection: [FoodModel] = []
    
    init() {
    #if DEBUG
        for _ in 0...20 {
            foodCollection.append(FoodModel())
        }
    #endif
    }
    
    
    @State var searchText: String = ""
    @State var searchIslandOffset: Double = 0
    
    @State var autoHide:CGFloat = 0.0
    @State var scrollSpyLastOffset:CGFloat = 0.0

    
    var body: some View {
        
        ZStack {
            Color.init(UIColor.secondarySystemBackground).ignoresSafeArea(.all)
            ScrollView{
                GeometryReader() { geometry -> Color in
                    
                    let minY = geometry.frame(in: .named("List")).minY
                    
                    DispatchQueue.main.async {
                        if (minY < 116.0 && minY > -697) {
                            //FIXME: CALCULATE SIZE OF BLOCKS
                            if (scrollSpyLastOffset == 0.0) {
                                scrollSpyLastOffset = minY
                            }
                            if (scrollSpyLastOffset > minY) {
                                if searchIslandOffset < 144 {
                                    searchIslandOffset += min(144,abs(scrollSpyLastOffset - minY))
                                    
                                }
                            }
                            else {
                                if searchIslandOffset > 0 {
                                    searchIslandOffset = max(0,searchIslandOffset - abs(scrollSpyLastOffset - minY))
                                }
                            }
                        }
                        print("\(geometry.size.width) \(geometry.size.height) \(minY)")
                        scrollSpyLastOffset = minY
                    }
                    return Color.clear
                }
                VStack(spacing: 8){
                    ForEach(foodCollection){ item in
                        HStack{
                            VStack(alignment: .leading) {
                                Text(item.name)
                                Text(item.description)
                                    .font(.tertiary)
                                    .foregroundColor(Color("TertiaryText"))
                            }
                            Spacer()
                            VStack(alignment: .center) {
                                Text("\(item.calories)")
                                Text("CAL").font(.trueCaption).foregroundColor(Color("TertiaryText"))
                            }
                            Divider().frame(height: 8)
                            VStack(alignment: .center) {
                                Text("\(item.portion)")
                                Text("GRAM").font(.trueCaption).foregroundColor(Color("TertiaryText"))
                            }
                        }.padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(.white)
                            .cornerRadius(8)
                            .padding(.horizontal, 16)
                    }.coordinateSpace(name: "List")
                }
            }
            VStack {
                Spacer()
                
                ZStack {

                    VStack{
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
                        HStack(alignment: .center) {
                            Image(systemName: "magnifyingglass")
                                .font(.body.weight(.semibold))
                                .foregroundColor(Color(hue: 240/360, saturation: 0.04, brightness: 0.58,opacity: 0.8))
                            TextField("Search", text: $searchText)
                        }.frame(height: 44)
                            .padding(.horizontal,8)
                            .background(.white)
                            .cornerRadius(16)
                            .padding(.horizontal, 8)
                        Spacer().frame(height: 54)
                    }.frame(maxWidth: .infinity, maxHeight: 144 + 54)
                        .background(.ultraThinMaterial)
                        .cornerRadius(16, corners: [.topLeft,.topRight])
                        .padding(.bottom,-searchIslandOffset - 54)
                        .animation(.easeOut(duration: 0.250))
                    
                    if (searchIslandOffset > 40) {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(maxWidth: .infinity, maxHeight: 144 + 54)
                            .contentShape(Rectangle())
                            .cornerRadius(16, corners: [.topLeft,.topRight])
                            .padding(.bottom,-searchIslandOffset - 54)
                            .animation(.easeOut(duration: 0.250))
                            .onTapGesture {
                                self.searchIslandOffset = 0
                            }
                    }
                }
                // See UI/Extensions/cornerRadiusCustom
            }
        }.navigationTitle("Food Collection")
    }
}


struct FoodCollection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            FoodCollection()
        }.previewDevice("iPhone SE (3rd generation)")
    }
}
