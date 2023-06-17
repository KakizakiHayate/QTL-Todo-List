//
//  LoginView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    var body: some View {
        VStack {
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
            Button {
                loginViewModel.googleLogin()
            } label: {
                Text("Googleログイン")
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
