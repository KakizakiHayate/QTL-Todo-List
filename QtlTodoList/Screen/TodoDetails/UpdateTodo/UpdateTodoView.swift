//
//  UpdateTodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct UpdateTodoView: View {
    // MARK: - Property Wrappers
    @StateObject private var firebaseManager  = FirebaseManager.shared
    @Environment(\.dismiss) private var dismiss
    @Binding var todos: Todos

    // MARK: - body
    var body: some View {
        ScrollView {
            VStack {
                TextField("入力", text: $todos.title)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextEditor(text: $todos.message)
                    .frame(height: 250)
                    .border(.gray, width: 2)
                    .padding()
                Button {
                    Task {
                        await firebaseManager.updateFirestoreData(todo: todos)
                        dismiss()
                    }
                } label: {
                    Text("完了")
                }.padding()
            }
        }
    } // body
} // view

// MARK: - Preview
struct UpdateTodoView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateTodoView(todos: .constant(Todos(title: "", message: "")))
    }
}
