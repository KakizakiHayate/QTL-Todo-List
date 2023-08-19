//
//  LoginButtonViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import Foundation
import FirebaseAuth

class LoginButtonViewModel: ObservableObject {
    // MARK: Property Wrappers
    @Published var errorMessage = FirebaseAuthError.unknown.title
    @Published var loginFailureAlert = false
}

extension LoginButtonViewModel {
    // MARK: - Methods
    /// メールアドレス/パスワードでログイン
    func login(email: String, password: String) async -> Bool {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            print("ログインしました")
            return true
        } catch {
            guard let error = error as NSError? else { return false }
            let errorCode = AuthErrorCode.Code(rawValue: error.code)
            Task { @MainActor in
                switch errorCode {
                case .invalidEmail:
                    errorMessage = FirebaseAuthError.invalidEmail.title
                case .emailAlreadyInUse:
                    errorMessage = FirebaseAuthError.emailAlreadyInUse.title
                case .userNotFound:
                    errorMessage = FirebaseAuthError.userNotFound.title
                case .networkError:
                    errorMessage = FirebaseAuthError.networkError.title
                case .wrongPassword:
                    errorMessage = FirebaseAuthError.wrongPassword.title
                default:
                    errorMessage = FirebaseAuthError.unknown.title
                }
            }
            return false
        }
    }
}
