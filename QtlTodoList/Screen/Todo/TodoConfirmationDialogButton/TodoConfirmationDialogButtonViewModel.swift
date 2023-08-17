//
//  TodoConfirmationDialogButtonViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import Foundation
import FirebaseAuth

class TodoConfirmationDialogButtonViewModel: ObservableObject {}

extension TodoConfirmationDialogButtonViewModel {
    // MARK: Methods
    func signOut() async -> Bool {
        do {
            try Auth.auth().signOut()
            print("サインアウトしました")
            return true
        } catch {
            print("サインアウトに失敗しました")
            return false
        }
    }

    func deleteAccount() async -> Bool {
        guard let user = Auth.auth().currentUser else { return false }
        do {
            try await user.delete()
            print("退会しました")
            return true
        } catch {
            return false
        }
    }
}
