//
//  TodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct TodoListView: View {
    // MARK: - Property Wrappers
    @StateObject private var firebaseManager = FirebaseManager.shared
    @State var todos = [Todos]()

    // MARK: - body
    var body: some View {
        NavigationStack {
            List {
                TodoListItemView(todos: $todos)
            }.onAppear {
                Task {
                    guard let todos = await firebaseManager.readFirestoreData() else {
                        return
                    }
                    self.todos = todos
                }
            }
        }
    } // body
} // view

// MARK: - Preview
struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
