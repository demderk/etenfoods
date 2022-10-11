//
//  ViewRouter.swift
//  eten
//
//  Created by Roman Zheglov on 04.10.2022.
//

import Foundation
import SwiftUI
import Firebase

enum ViewRouterPage: Hashable {
    case auth, main
}

class PagesRouter: ObservableObject {
    @Published var viewRouterPage: ViewRouterPage? = .auth
    
    init() {
        viewRouterPage = Auth.auth().currentUser == nil ? .auth : .main
    }

}

struct RouterView : View {
    @ObservedObject private var atPage: PagesRouter = PagesRouter()
    
    init() {

    }
    
    var body: some View {
        ZStack {
            switch atPage.viewRouterPage {
            case .main:
                MainPage(pagesRouter: atPage).transaction() {transaction in
                    transaction.animation = nil
                }
            case .auth:
                AuthPage(pagesRouter: atPage)
            default:
                Text("Whooops!")
                Text("Something went wrong.")
            }
        }
    }
}
