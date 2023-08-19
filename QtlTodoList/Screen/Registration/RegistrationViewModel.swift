//
//  RegistrationViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var name = "test"
    @Published var email = "test@example.com"
    @Published var password = "password"
    @Published var isTodoView = false
    @Published var registrationFailureAlert = false
    @Published var errorMessage = FirebaseAuthError.unknown.title
}

extension RegistrationViewModel {
    // MARK: - Methods
    /// 会員登録
    func registration() async -> Bool {
        do {
            let result = try await Auth.auth().createUser(withEmail: email,password: password)
            print(email)
            let request = result.user.createProfileChangeRequest()
            request.displayName = name
            try await request.commitChanges()
            try await result.user.sendEmailVerification()
            return true
        } catch {
            guard let error = error as NSError? else { return false }
            let errorCode = AuthErrorCode.Code(rawValue: error.code)
            Task { @MainActor in
                switch errorCode {
                case .networkError:
                    errorMessage = FirebaseAuthError.networkError.title
                case .weakPassword:
                    errorMessage = FirebaseAuthError.weakPassword.title
                case .invalidEmail:
                    errorMessage = FirebaseAuthError.invalidEmail.title
                case .emailAlreadyInUse:
                    errorMessage = FirebaseAuthError.emailAlreadyInUse.title
                default:
                    errorMessage = FirebaseAuthError.unknown.title
                }
            }
            print(error.localizedDescription)
            return false
        }
    }
}
