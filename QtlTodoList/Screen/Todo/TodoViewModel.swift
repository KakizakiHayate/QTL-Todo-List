//
//  TodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import Foundation

class TodoViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var isTodoAddDetails = false
    // MARK: - Properties
    static let shared = TodoViewModel()
}
