//
//  TodoListDetailView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/21.
//

import SwiftUI

struct TodoListItemView: View {
    // MARK: - Property Wrappers
    @ObservedObject private var firebaseManager = FirebaseManager.shared
    @Binding var todos: [Todos]

    // MARK: - body
    var body: some View {
        ForEach($todos) { todo in
                NavigationLink {
                    TodoListDetailView(todo: todo.projectedValue, todos: $todos)
                } label: {
                VStack(alignment: .leading) {
                        HStack {
                            Text(todo.wrappedValue.title)
                        }.padding(.bottom)
                            Text(todo.wrappedValue.message)
                        .font(.caption2)
                    }
                }
            }
    } // body
} // view

// MARK: - Preview
struct TodoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItemView(todos: .constant([]))
    }
}
