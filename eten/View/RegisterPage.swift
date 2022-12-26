//
//  AuthPage.swift
//  eten
//
//  Created by Roman Zheglov on 05.10.2022.
//

import Foundation
import SwiftUI
import Firebase

struct RegisterPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var passwordRepeat = ""
    @State private var loading = false
    @ObservedObject var mainRouter: PagesRouter = PagesRouter()
    @State private var skip = true
    @State private var lastErrorTitle : String? = nil
    @State private var lastErrorInfo = "!ERRORMSG"
    
    let animation: Animation = .easeOut(duration: 0.2)
    
    private enum SelectedField {
        case email,password, passwordRepeat
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
                    Spacer().frame(height: skip && lastErrorTitle == nil ? 56 : 32)
                    VStack {
                        Image("AuthIcon")
                            .resizable(resizingMode: .stretch)
                            .frame(width: 81.0, height: 60.0)
                        Spacer().frame(height: 24)
                        Text("Join to Eten Familly")
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
                        .frame(height: lastErrorTitle == nil ? 0 : 24)
                    if let error = lastErrorTitle {
                        ErrorCard(title: error, description: lastErrorInfo)
                            .onTapGesture {
                                withAnimation {
                                    lastErrorTitle = nil
                                    lastErrorInfo = ""
                                }
                            }
                    }
                    Spacer()
                        .frame(height: skip && lastErrorTitle == nil ? 56 : 24)
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
                                        lastErrorTitle = nil
                                        lastErrorInfo = ""
                                    }
                                }
                                .onSubmit {
                                    focus = .password
                                }
                            Spacer()
                                .frame(height: 8)
                            SecureField("Password", text: $password)
                                .frame(height: 44)
                                .textContentType(.newPassword)
                                .background() {
                                    Divider().offset(x: 0,y: 22)
                                }.focused($focus, equals: .password)
                                .onTapGesture {
                                    focus = .passwordRepeat
                                    withAnimation(animation) {
                                        skip = false
                                        lastErrorTitle = nil
                                        lastErrorInfo = ""
                                    }
                                }
                                .onSubmit {
                                    focus = nil
                                    withAnimation(animation) {
                                        skip = true
                                    }
                                }
                            SecureField("Repeat password", text: $passwordRepeat)
                                .frame(height: 44)
                                .textContentType(.password)
                                .background() {
                                    Divider().offset(x: 0,y: 22)
                                }.focused($focus, equals: .password)
                                .onTapGesture {
                                    withAnimation(animation) {
                                        skip = false
                                        lastErrorTitle = nil
                                        lastErrorInfo = ""
                                    }
                                }
                                .onSubmit {
                                    focus = .passwordRepeat
                                    withAnimation(animation) {
                                        skip = true
                                    }
                                }
                        }
                        Spacer(minLength: lastErrorTitle == nil ? 88 : 40)
                        VStack {
                            Button(action: {
                                loading = true
                                register(email: email, password: password)
                            }) {
                                if loading {
                                    ProgressView().progressViewStyle(.circular).frame(width: 310, height: 40)
                                } else {
                                    Text("Continue").frame(width: 310, height: 40)
                                }
                            }.buttonStyle(.borderedProminent)
                                .keyboardShortcut(.defaultAction)
                                .disabled(loading)
                            Spacer().frame(height: 8)
                            Button(action: {
                                withAnimation{
                                    mainRouter.viewRouterPage = .login
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
    
    func register(email: String, password: String) {
        if (password != passwordRepeat) {
            withAnimation{
                lastErrorTitle = "Registration Error"
                lastErrorInfo = "Passwords didn't match"
                loading = false
            }
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (result: AuthDataResult?, err: Error?) in
            if let error = err {
                withAnimation{
                    lastErrorTitle = "Registration Error"
                    lastErrorInfo = error.localizedDescription
                    print(lastErrorTitle ?? "Something went wrong")
                    loading = false
                
                }
                UINotificationFeedbackGenerator().notificationOccurred(.error)
                return
            }
            
            // Account setup
            
            mainRouter.viewRouterPage = .main
        }
        
    }
    
    struct RegisterPage_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                AuthPage(pagesRouter: PagesRouter())
                    .previewDevice("iPhone 8")
            }
        }
    }
}
