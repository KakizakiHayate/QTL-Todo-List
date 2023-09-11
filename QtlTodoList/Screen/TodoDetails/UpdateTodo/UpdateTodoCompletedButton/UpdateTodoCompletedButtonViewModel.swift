//
//  UpdateTodoCompletedButtonViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/09/06.
//

import Foundation
import SwiftUI

class UpdateTodoCompletedButtonViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @ObservedObject private var firebaseManager = FirebaseManager.shared
}

extension UpdateTodoCompletedButtonViewModel {
    // MARK: - Methods
    func imageUploadAndUpdateTodo(todoImage: UIImage, todos: Todos) async {
        let uploadUrl = await firebaseManager.todoImageUpload(image: todoImage)
        await firebaseManager.updateFirestoreData(todo: todos, uploadUrl: uploadUrl)
    }
}
