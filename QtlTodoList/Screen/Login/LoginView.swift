//
//  LoginView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct LoginView: View {
    // MARK: - Property Wrappers
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isRegistrationView = false
    
    // MARK: Properties
    private let screenSize = UIScreen.main.bounds.height
    
    // MARK: - body
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            NavigationStack {
                VStack {
                    Spacer()
                    TextField(AppConst.Text.inputMail, text: $loginViewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField(AppConst.Text.inputPassword, text: $loginViewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button {
                        if !loginViewModel.email.isEmpty &&
                            !loginViewModel.password.isEmpty {
                            Task {
                                if await loginViewModel.login() {
                                    loginViewModel.isTodoView.toggle()
                                } else {
                                    loginViewModel.loginFailureAlert.toggle()
                                }
                            }
                        } else {
                            loginViewModel.loginFailureAlert.toggle()
                        }
                    } label: {
                        Text(AppConst.Text.login)
                    }.padding()
                        .background(Color.customColorEmeraldGreen)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(30)
                        .alert(loginViewModel.errorMessage, isPresented: $loginViewModel.loginFailureAlert) {
                            Button {} label: { Text(AppConst.Text.ok) }
                        } message: {
                            Text(AppConst.Text.retry)
                        }
                    Spacer().frame(height: height / 15)
                    Text(AppConst.separatorText.or).foregroundColor(.gray)
                    Button {
                        loginViewModel.googleLogin()
                    } label: {
                        Text(AppConst.Text.googleLogin)
                    }.padding()
                        .font(.headline)
                        .foregroundColor(.customColorEmeraldGreen)
                        .background(.white)
                        .cornerRadius(30)
                        .compositingGroup()
                        .shadow(color: .gray.opacity(0.7) ,radius: 3)
                        .padding()
                        .alert(AppConst.Text.googleLoginFailure, isPresented: $loginViewModel.googleLoginFailureAlert) {
                            Button {} label: { Text(AppConst.Text.ok) }
                        } message: {
                            Text(AppConst.Text.retry)
                        }
                    Text(AppConst.separatorText.notRegistered)
                        .foregroundColor(.gray)
                    Button {
                        isRegistrationView.toggle()
                    } label: {
                        Text(AppConst.Text.newRegistration)
                    }.padding()
                        .font(.headline)
                        .foregroundColor(.customColorEmeraldGreen)
                        .background(.white)
                        .cornerRadius(30)
                        .compositingGroup()
                        .shadow(color: .gray.opacity(0.7) ,radius: 3)
                        .padding()
                }
                .navigationDestination(isPresented: $loginViewModel.isTodoView) {
                    TodoView(isTodoView: $loginViewModel.isTodoView)
                }
                .navigationDestination(isPresented: $isRegistrationView) {
                    RegistrationView(isTodoView: $loginViewModel.isTodoView)
                }
            }
        }
    } // body
} // view

// MARK: - Preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}