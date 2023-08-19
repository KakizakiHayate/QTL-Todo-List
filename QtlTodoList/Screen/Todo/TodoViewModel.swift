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
    @Published var isConfirmationDialogAccount = false
    @Published var isFailureAlert = false
    @Published var dialogTitle = ""
}
