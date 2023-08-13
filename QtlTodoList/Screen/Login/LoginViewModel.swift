//
//  LoginViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation

class LoginViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var email = "test@example.com"
    @Published var password = "password"
    @Published var isTodoView = false
}
