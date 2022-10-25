//
//  AuthPage.swift
//  eten
//
//  Created by Roman Zheglov on 05.10.2022.
//

import Foundation
import SwiftUI
import Firebase

struct AuthPage: View {
    @State private var email = "b@ya.ru"
    @State private var password = "qwerty"
    @State private var loading = false
    @ObservedObject var mainRouter: PagesRouter = PagesRouter()
    @State private var skip = true
    
    
    let animation: Animation = .easeOut(duration: 0.2)
    
    private enum SelectedField {
        case email, password
    }
    
    @FocusState private var focus: SelectedField?
    
    init(pagesRouter: PagesRouter) {
        mainRouter = pagesRouter
    }
    
    var body: some View {
        GeometryReader{ _ in
            ZStack {
                Color.init(UIColor.secondarySystemBackground).ignoresSafeArea(.all).onTapGesture {
                    focus = nil
                    withAnimation(animation) {
                        skip = true
                    }
                }
                VStack {
                    Spacer().frame(height: skip && mainRouter.lastErrorTitle == nil ? 72 : 48)
                    VStack {
                        Image("AuthIcon")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 81.0, height: 60.0)
                        Spacer().frame(height: 24)
                        Text("Connect to Eten Familly")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        Spacer()
                            .frame(height: 8.0)
                        Text("All Eten services\nin one account")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("TertiaryText"))
                    }
                    Spacer()
                        .frame(height: mainRouter.lastErrorTitle == nil ? 0 : 24)
                    if let error = mainRouter.lastErrorTitle {
                        ErrorCard(title: error, description: mainRouter.lastErrorInfo)
                            .onTapGesture {
                                withAnimation {
                                    mainRouter.lastErrorTitle = nil
                                    mainRouter.lastErrorInfo = ""
                                }
                            }
                    }
                    Spacer()
                        .frame(height: skip && mainRouter.lastErrorTitle == nil ? 56 : 24)
                    VStack {
                        VStack{
                            TextField("Email", text: $email)
                                .frame(height: 44)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .textContentType(.emailAddress)
                                .background() {
                                    Divider().offset(x: 0,y: 22)
                                }
                                .focused($focus, equals: .email)
                                .onTapGesture {
                                    withAnimation(animation) {
                                        skip = false
                                        mainRouter.lastErrorTitle = nil
                                        mainRouter.lastErrorInfo = ""
                                    }
                                }
                                .onSubmit {
                                    focus = .password
                                }
                            Spacer()
                                .frame(height: 8)
                            SecureField("Password", text: $password)
                                .frame(height: 44)
                                .textContentType(.password)
                                .background() {
                                    Divider().offset(x: 0,y: 22)
                                }.focused($focus, equals: .password)
                                .onTapGesture {
                                    withAnimation(animation) {
                                        skip = false
                                        mainRouter.lastErrorTitle = nil
                                        mainRouter.lastErrorInfo = ""
                                    }
                                }
                                .onSubmit {
                                    focus = nil
                                    withAnimation(animation) {
                                        skip = true
                                    }
                                }
                            
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                print(mainRouter.lastErrorInfo)
                            },label: { Text("Forgot password?")})
                                .foregroundColor(.init(white: 0.58))
                                .font(.caption.weight(.regular))
                        }
                        Spacer(minLength: mainRouter.lastErrorTitle == nil ? 88 : 40)
                        VStack {
                            Button(action: {
                                loading = true
                                login(email: email, password: password)
                            }) {
                                if loading {
                                    ProgressView().progressViewStyle(.circular).frame(width: 310, height: 40)
                                } else {
                                    Text("Continue").progressViewStyle(.circular).frame(width: 310, height: 40)
                                }
                            }.buttonStyle(.borderedProminent)
                                .keyboardShortcut(.defaultAction)
                                .disabled(loading)
                            Spacer().frame(height: 8)
                            Button(action: {
                                withAnimation{
                                    mainRouter.viewRouterPage = .register
                                }
                            }) {
                                Text("Create account").frame(width: 310, height: 40)
                            }.frame(width: 310, height: 48)
                                .foregroundColor(.blue)
                                .font(Font.body)
                                .disabled(loading)
                        }
                        Spacer().frame(height: 16)
                    }.frame(width: 327)
                }
            }
        }.ignoresSafeArea(.keyboard)
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { comp, err in
            if let error = err {
                withAnimation {
                    mainRouter.lastErrorTitle = "Login Error"
                    mainRouter.lastErrorInfo = error.localizedDescription
                    loading = false
                }
                UINotificationFeedbackGenerator().notificationOccurred(.error)
                return
            }
            loading = false
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            //            withAnimation{
            mainRouter.viewRouterPage = .main
            
            //            }
            print("Login as \(email) \(password)")
        }
    }
    
}

struct AuthPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AuthPage(pagesRouter: PagesRouter())
                .previewDevice("iPhone 8")
        }
    }
}
