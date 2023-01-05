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
    @State var searchIslandOpacity = 1.0
    
    var body: some View {
        
        ZStack {
            Color.init(UIColor.secondarySystemBackground).ignoresSafeArea(.all)
            ScrollView{
                GeometryReader() { geometry -> Color in
                    let foodBlockSize = 30
                    let bottomAnimationSkip = CGFloat(-foodBlockSize * foodCollection.count + 116)
                    let minY = geometry.frame(in: .named("List")).minY

                    DispatchQueue.main.async {
                        if (minY < 116.0 && minY > bottomAnimationSkip) {
                            if (scrollSpyLastOffset == 0.0) {
                                scrollSpyLastOffset = minY
                            }
                            if (scrollSpyLastOffset > minY) {
                                if searchIslandOffset < 144 + 54 {
                                    searchIslandOffset += min(144 + 54,abs(scrollSpyLastOffset - minY))
                                    searchIslandOpacity = 1 - searchIslandOffset / (144 + 54) * 2
                                }
                            }
                            else {
                                if searchIslandOffset > 0 {
                                    searchIslandOffset = max(0,searchIslandOffset - abs(scrollSpyLastOffset - minY))
                                    searchIslandOpacity = 1 - searchIslandOffset / (144 + 54) * 2
                                }
                            }
                        }
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
                    Spacer().frame(height: 16)
                }
            }
            
            FoodSearchView(searchIslandOpacity: $searchIslandOpacity, searchText: $searchText, searchIslandOffset: $searchIslandOffset)
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
