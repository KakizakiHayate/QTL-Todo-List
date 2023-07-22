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
            let width = proxy.size.width
            let height = proxy.size.height
            NavigationStack {
                VStack {
                    Spacer()
                    TextField("メールアドレスを入力", text: $loginViewModel.email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    TextField("パスワードを入力", text: $loginViewModel.password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button {
                        loginViewModel.login()
                    } label: {
                        Text("ログインする")
                    }.padding()
                        .background(Color.customColorEmeraldGreen)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(30)
                    Spacer().frame(height: height / 15)
                    Text("--- または ---").foregroundColor(.gray)
                    Button {
                        loginViewModel.googleLogin()
                    } label: {
                        Text("Googleログイン")
                    }.padding()
                        .font(.headline)
                        .foregroundColor(.customColorEmeraldGreen)
                        .background(.white)
                        .cornerRadius(30)
                        .compositingGroup()
                        .shadow(color: .gray.opacity(0.7) ,radius: 3)
                        .padding()
                    Text("--- 登録されてない方はコチラ ---")
                        .foregroundColor(.gray)
                    Button {
                        isRegistrationView.toggle()
                    } label: {
                        Text("新規登録")
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
                    TodoView()
                }
                .navigationDestination(isPresented: $isRegistrationView) {
                    RegistrationView()
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
