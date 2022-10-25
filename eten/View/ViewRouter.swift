//
//  ViewRouter.swift
//  eten
//
//  Created by Roman Zheglov on 04.10.2022.
//

import Foundation
import SwiftUI
import Firebase
import Combine

enum ViewRouterPage: Hashable {
    case register
    case login
    case main
}

class PagesRouter: ObservableObject {
    @Published var viewRouterPage: ViewRouterPage? = .register
    @Published var lastErrorTitle: String? = nil
    @Published var lastErrorInfo: String = "!ERRORMSG"
    
    var loginCheckPublisher = Timer.publish(every: 10.0, on: .main, in: .common).autoconnect()
    
    var loginCheckStore = Set<AnyCancellable>()
    
    var onError = Set<AnyCancellable>()
    
    init() {
        
        viewRouterPage = Auth.auth().currentUser == nil ? .login : .main
        
        loginCheckPublisher.sink{ data in
            Auth.auth().currentUser?.reload() { inError in
                if let error = inError {
                    print(error.localizedDescription)
                    self.lastErrorTitle = "Login Error"
                    self.lastErrorInfo = error.localizedDescription
                    self.viewRouterPage = .login
                    self.objectWillChange.send()
                    print(self.lastErrorInfo)
                }
            }
        }.store(in: &loginCheckStore)
    }
    
}

struct RouterView : View {
    @ObservedObject private var atPage: PagesRouter = PagesRouter()
    
    private var userChangedHandle: AuthStateDidChangeListenerHandle? = nil
    
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
