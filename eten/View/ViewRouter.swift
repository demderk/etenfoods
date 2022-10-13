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
    case register
    case login
    case main
}

class PagesRouter: ObservableObject {
    @Published var viewRouterPage: ViewRouterPage? = .register
    
    init() {
        viewRouterPage = Auth.auth().currentUser == nil ? .login : .main
    }

}

struct RouterView : View {
    @ObservedObject private var atPage: PagesRouter = PagesRouter()
    
    init() {
    }
    
    var body: some View {
        ZStack {
            Color.init(UIColor.secondarySystemBackground).ignoresSafeArea(.all)
            
            switch atPage.viewRouterPage {
            case .main:
                MainPage(pagesRouter: atPage)
                    .transition(.opacity)
            case .login:
                AuthPage(pagesRouter: atPage)
                    .transition(.opacity)
            case .register:
                RegisterPage(pagesRouter: atPage)
                    .transition(.opacity)
            default:
                Text("Whooops!")
                Text("Something went wrong.")
            }
            
        }
    }
}
