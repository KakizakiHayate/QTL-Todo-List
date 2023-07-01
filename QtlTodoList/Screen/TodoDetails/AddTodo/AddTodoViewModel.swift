//
//  UpdateTodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/24.
//

import Foundation

class AddTodoViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var title = ""
    @Published var message = ""
    @Published var isTextEmpty = false
    // MARK: - Properties
    static let shared = AddTodoViewModel()
}
