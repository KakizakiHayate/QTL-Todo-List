//
//  TodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation
import FirebaseAuth

class TodoViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var isTodoAddDetails = false
    @Published var isConfirmationSignOut = false
    @Published var isSignOutFailureAlert = false
}

extension TodoViewModel {
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
}
