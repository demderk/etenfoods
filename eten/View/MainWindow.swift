//
//  MainWindow.swift
//  eten
//
//  Created by Roman Zheglov on 24.09.2022.
//

import Foundation
import SwiftUI
import Firebase

struct MainPage: View {
    @ObservedObject var caloriesVM: MainPageVM = MainPageVM()
    @ObservedObject var mainRouter: PagesRouter = PagesRouter()
    
    init(pagesRouter: PagesRouter) {
        mainRouter = pagesRouter
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color.init(UIColor.secondarySystemBackground).ignoresSafeArea(.all)
                    ScrollView {
                        VStack {
                            Spacer()
                                .frame(height: 8.0)
                            PersonalProgressCard()
                            CaloriesCard(caloriesData: caloriesVM.caloriesData)
                            StepsCard(stepsData: caloriesVM.stepsData)
                            Button(action: {
                                caloriesVM.caloriesPush(count: 100)
                                print("dasd")
                            }, label: {
                                Text("PUSH")
                            })
                            Button(action: {
                                do {
                                    try Auth.auth().signOut()
                                    mainRouter.viewRouterPage = .auth
                                    print("Signed out")
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }, label: {
                                Text("SIGN OUT")
                            })
                            Spacer()
                        }.navigationTitle("Summary")
                    }
                }
            }
        }
    }
}
