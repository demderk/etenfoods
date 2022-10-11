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
    @State private var email = ""
    @State private var password = ""
    @State private var loading = false
    @ObservedObject var mainRouter: PagesRouter = PagesRouter()
    @State private var skip = true
    
    let animation: Animation = .easeOut(duration: 0.2)
    
    private enum SelectedField {
        case username, password
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
                    Spacer().frame(height: skip ? 120 : 0)
                    VStack {
                        Text("Connect to Eten Familly")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .lineLimit(1)
                        Spacer()
                            .frame(height: 8.0)
                        Text("All Eten services\nin one account")
                            .multilineTextAlignment(.center)
                    }.frame(height: 100)
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Image(systemName: "arrow.up.heart.fill")
                            Text("Login error")
                        }
                        
                        Text("kjdsakjdhajkd sajdhkjasdh")
                        
                    }.frame(width: 320, height: 64, alignment: .leading)
                        .background {
                            RoundedRectangle(cornerRadius: 8).fill(Color.init(hue: 0.03, saturation: 0.22, brightness: 1, opacity: 0.2))
                        }
                    Spacer()
                        .frame(height: 88)
                    VStack {
                        VStack{
                            TextField("Email or username", text: $email)
                                .frame(height: 44)
                                .keyboardType(.emailAddress)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                                .textContentType(.emailAddress)
                                .background() {
                                    Divider().offset(x: 0,y: 22)
                                }
                                .focused($focus, equals: .username)
                                .onTapGesture {
                                    withAnimation(animation) {
                                        skip = false
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
                            Button(action: {},label: { Text("Forgot password?")})
                                .foregroundColor(.init(white: 0.58))
                                .font(.caption.weight(.regular))
                        }
                        Spacer(minLength: 88)
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
                            Button("Create account") {
                                
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
                print(error.localizedDescription)
                loading = false
                UINotificationFeedbackGenerator().notificationOccurred(.error)
                return
            }
            loading = false
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            mainRouter.viewRouterPage = .main
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
