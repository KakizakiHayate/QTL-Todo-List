//
//  TodoListDetailView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/21.
//

import SwiftUI

struct TodoListDetailView: View {
    // MARK: - Property Wrappers
    @State private var isTodoUpdateDetails = false
    @StateObject private var firebaseManager = FirebaseManager.shared
    // MARK: - Properties
    private let todo: Todos
    // MARK: init
    init(todo: Todos) {
        self.todo = todo
    }

    // MARK: - body
    var body: some View {
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
                    }
                    .navigationDestination(isPresented: $isTodoUpdateDetails) {
                        UpdateTodoView()
                    }
                    .padding(.trailing)
                Image(systemName: "trash")
                    .foregroundColor(.customColorEmeraldGreen)
                    .font(.title2)
                    .onTapGesture { firebaseManager.deleteFirestoreData(todo: todo) }
            }.padding(.bottom)
            Text(todo.message)
        }
    } // body
} // view

// MARK: - Preview
struct TodoListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListDetailView(todo: Todos(title: "", message: ""))
    }
}
