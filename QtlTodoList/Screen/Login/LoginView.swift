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
                    SecureField(AppConst.Text.inputPassword, text: $loginViewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    LoginButtonView(email: $loginViewModel.email,
                                    password: $loginViewModel.password,
                                    isTodoView: $loginViewModel.isTodoView)
                    Spacer().frame(height: height / 15)
                    Text(AppConst.separatorText.or).foregroundColor(.gray)
                    GoogleLoginButtonView(isTodoView: $loginViewModel.isTodoView)
                    Text(AppConst.separatorText.notRegistered)
                        .foregroundColor(.gray)
                    Button {
                        loginViewModel.isRegistrationView.toggle()
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
                }.navigationDestination(isPresented: $loginViewModel.isTodoView) {
                    TodoView(isTodoView: $loginViewModel.isTodoView)
                }.navigationDestination(isPresented: $loginViewModel.isRegistrationView) {
                    RegistrationView(isTodoView: $loginViewModel.isTodoView, isRegistrationView: $loginViewModel.isRegistrationView)
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
