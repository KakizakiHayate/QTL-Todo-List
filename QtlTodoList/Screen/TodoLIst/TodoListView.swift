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
    
    // MARK: - body
    var body: some View {
        List {
            ForEach(firebaseManager.todos) { todo in
                TodoListDetailView(todo: todo)
            }
        }
        .onAppear {
            firebaseManager.readFirestoreData()
        }
    } // body
} // view

// MARK: - Preview
struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}
