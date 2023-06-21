//
//  UpdateTodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct UpdateTodoView: View {
    // MARK: - Property Wrappers
    @StateObject private var todoViewModel = TodoViewModel.shared
    @Environment(\.dismiss) private var dismiss

    // MARK: - body
    var body: some View {
        ScrollView {
            VStack {
                TextField("入力", text: $todoViewModel.todo.title)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextEditor(text: $todoViewModel.todo.message)
                    .frame(height: 250)
                    .border(.gray, width: 2)
                    .padding()
                Button {
                    todoViewModel.updateFirestoreData(todo: todoViewModel.todo)
                    dismiss()
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
        UpdateTodoView()
    }
}
