//
//  LoginButtonView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import SwiftUI

struct LoginButtonView: View {
    // MARK: - Property Wrappers
    @Binding var email: String
    @Binding var password: String
    @Binding var isTodoView: Bool
    @StateObject private var loginButtonViewModel = LoginButtonViewModel()

    // MARK: - body
    var body: some View {
        Button {
            if !email.isEmpty &&
                !password.isEmpty {
                Task {
                    if await loginButtonViewModel.login(email: email, password: password) {
                        isTodoView.toggle()
                    } else {
                        loginButtonViewModel.loginFailureAlert.toggle()
                    }
                }
            } else {
                loginButtonViewModel.loginFailureAlert.toggle()
            }
        } label: {
            Text(AppConst.Text.login)
        }.padding()
            .background(Color.customColorEmeraldGreen)
            .foregroundColor(.white)
            .font(.headline)
            .cornerRadius(30)
            .alert(loginButtonViewModel.errorMessage, isPresented: $loginButtonViewModel.loginFailureAlert) {
                Button {} label: { Text(AppConst.Text.confirmationOk) }
            } message: {
                Text(AppConst.Text.retry)
            }
    } // body
} // view

// MARK: - Preview
struct LoginButtonView_Previews: PreviewProvider {
    static var previews: some View {
        LoginButtonView(email: .constant(""), password: .constant(""), isTodoView: .constant(false))
    }
}
