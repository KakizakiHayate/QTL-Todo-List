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
}

extension RegistrationViewModel {
    // MARK: - Methods
    /// 会員登録
    func registration() {
        Task {
            do {
                let result = try await Auth.auth().createUser(withEmail: email,password: password)
                print(email)
                let request = result.user.createProfileChangeRequest()
                request.displayName = name
                try await request.commitChanges()
                try await result.user.sendEmailVerification()
                Task.detached { @MainActor in
                    self.isTodoView.toggle()
                }
            } catch let error {
                // TODO: エラーだった場合は、違うメソッドに飛ばしてエラー表示をScreenにもする
                registrationFailureAlert.toggle()
                print(error.localizedDescription)
            }
        }
    }
}
