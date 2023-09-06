//
//  AddTodoCompletedButtonViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/09/06.
//

import Foundation
import SwiftUI

class AddTodoCompletedButtonViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @ObservedObject private var firebaseManager = FirebaseManager.shared
}

// MARK: - extension
extension AddTodoCompletedButtonViewModel {
    // MARK: - Methods
    func uploadTodoData(addImage: UIImage, title: String, message: String) async {
        let uploadUrl = await firebaseManager.todoImageUpload(image: addImage)
        await firebaseManager.createFirestoreData(title: title,
                                                  message: message,
                                                  imageUrl: uploadUrl)
    }

    func clearTextField(title: Binding<String>, message: Binding<String>) {
        title.wrappedValue = ""
        message.wrappedValue = ""
    }
}
