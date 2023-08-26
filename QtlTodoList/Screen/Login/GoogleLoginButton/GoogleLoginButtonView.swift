//
//  GoogleLoginButton.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import SwiftUI

struct GoogleLoginButtonView: View {
    // MARK: - Property Wrappers
    @Binding var isTodoView: Bool
    @StateObject private var googleLoginButtonViewModel = GoogleLoginButtonViewModel()

    // MARK: - body
    var body: some View {
        Button {
            googleLoginButtonViewModel.googleLogin { result in
                if result {
                    isTodoView.toggle()
                } else {
                    googleLoginButtonViewModel.isGoogleLoginFailureAlert.toggle()
                }
            }
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
            .alert(AppConst.Text.googleLoginFailure, isPresented: $googleLoginButtonViewModel.isGoogleLoginFailureAlert) {
                Button {} label: { Text(AppConst.Text.ok) }
            } message: {
                Text(AppConst.Text.retry)
            }
    } // body
} // view

// MARK: - Preview
struct GoogleLoginButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleLoginButtonView(isTodoView: .constant(false))
    }
}
