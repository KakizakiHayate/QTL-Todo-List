//
//  TodoListDetailView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/21.
//

import SwiftUI

struct TodoListItemView: View {
    // MARK: - Property Wrappers
    @State private var isTodoUpdateDetails = false
    @ObservedObject private var firebaseManager = FirebaseManager.shared
    @Binding var todos: [Todos]

    // MARK: - body
    var body: some View {
        ForEach(todos) { todo in
            VStack(alignment: .leading) {
                HStack {
                    Text(todo.title)
                    Spacer()
                    Image(systemName: "pencil")
                        .foregroundColor(.customColorEmeraldGreen)
                        .font(.title)
                        .onTapGesture {
                            firebaseManager.todo = todo
                            isTodoUpdateDetails.toggle()
                        }.navigationDestination(isPresented: $isTodoUpdateDetails) {
                            UpdateTodoView()
                        }.padding(.trailing)
                    Image(systemName: "trash")
                        .foregroundColor(.customColorEmeraldGreen)
                        .font(.title2)
                        .onTapGesture {
                            Task {
                                await firebaseManager.deleteFirestoreData(todo: todo)
                                guard let todos = await firebaseManager.readFirestoreData() else {
                                    return
                                }
                                self.todos = todos
                            }
                        }
                }.padding(.bottom)
                Text(todo.message)
            }
        }
    } // body
} // view

// MARK: - Preview
struct TodoListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListItemView(todos: .constant([]))
    }
}
