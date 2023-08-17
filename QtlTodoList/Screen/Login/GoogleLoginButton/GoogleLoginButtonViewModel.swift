//
//  GoogleLoginButtonViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import Foundation
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class GoogleLoginButtonViewModel: ObservableObject {
    // MARK: Property Wrappers
    @Published var isGoogleLoginFailureAlert = false
}

extension GoogleLoginButtonViewModel {
    // MARK: Methods
    /// Googleログイン
    func googleLogin(completion: @escaping(Bool) -> Void) {
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
                completion(false)
                return
            }
            guard let user = result?.user else {
                completion(false)
                return
            }
            guard let idToken = user.idToken?.tokenString else {
                completion(false)
                return
            }
            GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            completion(true)
        }
        return
    }
}
