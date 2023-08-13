//
//  LoginViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

class LoginViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var email = "test@example.com"
    @Published var password = "password"
    @Published var isTodoView = false
    @Published var loginFailureAlert = false
    @Published var googleLoginFailureAlert = false
    @Published var errorMessage = FirebaseAuthError.unknown.title
}

extension LoginViewModel {
    // MARK: - Methods
    /// メールアドレス/パスワードでログイン
    func login() async -> Bool {
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

    /// Googleログイン
    func googleLogin() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        guard let rootViewController = windowScene?.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            guard error == nil else {
                print("GIDSignInError: \(error?.localizedDescription ?? "error nil::::")")
                return
            }
            guard let user = result?.user else { return }
            guard let idToken = user.idToken?.tokenString else { return }
            GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Task { @MainActor in
                self.isTodoView.toggle()
            }
        }
        return
    }
}
