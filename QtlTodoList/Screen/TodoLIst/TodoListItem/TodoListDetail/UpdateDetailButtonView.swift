//
//  UpdateDeleteButtonView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/17.
//

import SwiftUI

struct UpdateDetailButtonView: View {
    // MARK: - Property Wrrapers
    @State private var isUpdateTodoView = false
    @State private var isDeleteAlert = false
    @Binding var todos: Todos
    @Binding var todoImage: UIImage
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
                    UpdateTodoView(todos: $todos, todoImage: $todoImage)
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
                .alert(AppConst.Text.deleteTask, isPresented: $isDeleteAlert) {
                    Button {} label: { Text(AppConst.Text.cancel) }
                    Button {
                        Task {
                            firebaseManager.deleteFirestoreData(todo:)
                        }
                    } label: {
                        Text(AppConst.Text.ok)
                    }
                }
        }
    } // body
} // view

// MARK: - Preview
struct UpdateDetailButtonView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateDetailButtonView(todos: .constant(Todos(title: "", message: "", uploadUrl: "")), todoImage: .constant(UIImage()))
    }
}
