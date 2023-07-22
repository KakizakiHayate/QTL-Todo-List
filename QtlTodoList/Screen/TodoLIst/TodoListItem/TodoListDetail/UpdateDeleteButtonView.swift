//
//  UpdateDeleteButtonView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/17.
//

import SwiftUI

struct UpdateDeleteButtonView: View {
    // MARK: - Property Wrrapers
    @State private var isUpdateTodoView = false
    @State private var isDeleteAlert = false
    @Binding var todos: Todos
    @StateObject private var firebaseManager = FirebaseManager.shared

    // MARK: - body
    var body: some View {
        HStack {
            Button {
                isUpdateTodoView.toggle()
            } label: {
                Image(systemName: "pencil")
            }.foregroundColor(.white)
                .padding()
                .font(.system(size: 30))
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.customColorEmeraldGreen)
                ).padding()
                .navigationDestination(isPresented: $isUpdateTodoView) {
                    UpdateTodoView(todos: $todos)
                }
            Button {
                isDeleteAlert.toggle()
            } label: {
                Image(systemName: "trash")
            }.foregroundColor(.white)
                .padding()
                .font(.system(size: 25))
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.customColorEmeraldGreen)
                ).padding()
                .alert("このタスクを削除しますか？", isPresented: $isDeleteAlert) {
                    Button {} label: { Text("キャンセル") }
                    Button {
                        Task {
                            firebaseManager.deleteFirestoreData(todo:)
                        }
                    } label: {
                        Text("OK")
                    }
                }
        }
    } // body
} // view

// MARK: - Preview
struct UpdateDeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDeleteButtonView(todos: .constant(Todos(title: "", message: "")))
    }
}
