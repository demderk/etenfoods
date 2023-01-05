//
//  Diary.swift
//  eten
//
//  Created by Roman Zheglov on 08.12.2022.
//

import SwiftUI

struct HistoryUnit: Identifiable {
    var id = UUID()
    
    
    
    var name = "Unnamed"
    var carbs: Double = 0
    var protein: Double = 0
    var fats: Double = 0
    var calories: Int = 0
    var portion: Int = 0
    var group: String = "Inbox"
}

struct HistoryGroup: Identifiable{
    var id = UUID() // group number
    
    var title = "Group Title"
    var content: [HistoryUnit]
    var totalCalories: Int {
        content.reduce(0, {x, y in
            x + y.calories
        })
    }
}

struct DiaryListUnit: View {
    var group: HistoryGroup
    
    
    init(group: HistoryGroup) {
        self.group = group
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .firstTextBaseline) {
                Text(group.title)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(Color(hue: 241/360, saturation: 0.60, brightness: 0.84))
                Spacer()
                Text("\(group.totalCalories) CAL")
                    .font(.tertiary)
                    .foregroundColor(Color("TertiaryText"))
                    .fontWeight(.medium)
            }.padding(.horizontal)
            Spacer().frame(height: 3)
            Divider()
                .background(Color(hue: 241/360, saturation: 0.60, brightness: 0.84, opacity: 0.15))
                .padding(.horizontal,8)
            ForEach(group.content) { item in
                HStack{
                    VStack(alignment: .leading) {
                        Text(item.name)
                        Spacer().frame(height: 3)
                        HStack(alignment: .center) {
                            Text("Carbs \(String(format: "%.1f", item.carbs))")
                            Divider().frame(height: 8).overlay(Color(UIColor.systemGray))
                            Text("Protein \(String(format: "%.1f", item.protein))")
                            Divider().frame(height: 8).overlay(Color(UIColor.systemGray))
                            Text("Fats \(String(format: "%.1f", item.fats))")
                        }.font(.tertiary).foregroundColor(Color("TertiaryText"))
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
                }.padding(.top, 3)
                Spacer().frame(height: 5)
            }.padding(.horizontal)
        }
    }
}

struct Diary: View {
    @State var searchText: String = ""
    @State var searchIslandOffset: Double = 0
    
    @State var autoHide:CGFloat = 0.0
    @State var scrollSpyLastOffset:CGFloat = 0.0
    @State var searchIslandOpacity = 1.0
    
    var isSearchActivated:Bool {
        get {
            return searchText != ""
        }
    }
    
    var foodItems: [HistoryUnit] = []
    var firstFoodGroup: [HistoryGroup] = []
    
    init() {
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        foodItems.append(HistoryUnit())
        firstFoodGroup.append(HistoryGroup(title: "First", content: foodItems))
        firstFoodGroup.append(HistoryGroup(title: "First", content: foodItems))
    }
    
    var body: some View {
        ZStack{
            if (!isSearchActivated) {
                VStack {
                    ScrollView {
//                        GeometryReader() { geometry -> Color in
//                            let foodBlockSize = 30
//                            let bottomAnimationSkip = CGFloat(-foodBlockSize * foodItems.count + 116)
//                            let minY = geometry.frame(in: .named("List")).minY
//                            
//                            DispatchQueue.main.async {
//                                if (minY < 116.0 && minY > bottomAnimationSkip) {
//                                    if (scrollSpyLastOffset == 0.0) {
//                                        scrollSpyLastOffset = minY
//                                    }
//                                    if (scrollSpyLastOffset > minY) {
//                                        if searchIslandOffset < 144 + 54 {
//                                            searchIslandOffset += min(144 + 54,abs(scrollSpyLastOffset - minY))
//                                            searchIslandOpacity = 1 - searchIslandOffset / (144 + 54) * 2
//                                        }
//                                    }
//                                    else {
//                                        if searchIslandOffset > 0 {
//                                            searchIslandOffset = max(0,searchIslandOffset - abs(scrollSpyLastOffset - minY))
//                                            searchIslandOpacity = 1 - searchIslandOffset / (144 + 54) * 2
//                                        }
//                                    }
//                                }
//                                scrollSpyLastOffset = minY
//                            }
//                            return Color.clear
//                        }
                        HStack(alignment: .center) {
                            Image(systemName: "calendar")
                            Spacer().frame(width: 4)
                            Text("June 22").font(.system(size: 20))
                            Spacer()
                        }
                        .font(.body)
                        .foregroundColor(Color(UIColor.systemBlue))
                        .padding(.horizontal)
                        .padding(.top, -7)
                        Spacer().frame(height: 10)
                        ForEach(firstFoodGroup) { item in
                            DiaryListUnit(group: item)
                        }
                        Spacer().frame(height: 8)
                    }
                }
            }
            else {
                Text("You are searching \(searchText)")
            }
            FoodSearchView(searchIslandOpacity: $searchIslandOpacity, searchText: $searchText, searchIslandOffset: $searchIslandOffset)
        }.navigationBarTitleDisplayMode(isSearchActivated ? .inline : .automatic).navigationTitle(isSearchActivated ? "Search" : "Diary")
    }
}

struct Diary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Diary().navigationTitle("Diary")
        }
        .previewDevice(/*@START_MENU_TOKEN@*/"iPhone SE (3rd generation)"/*@END_MENU_TOKEN@*/)
    }
}
