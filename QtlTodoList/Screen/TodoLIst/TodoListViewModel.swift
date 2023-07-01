//
//  TodoListViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/27.
//

import Foundation

class TodoListViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var todos = [Todos]()
    private let firebaseManager = FirebaseManager.shared
}

extension TodoListViewModel {
    // MARK: - Methods
    func fetchTodoData() {
        firebaseManager.readFirestoreData { todos in
            self.todos = todos
        }
    }
}
