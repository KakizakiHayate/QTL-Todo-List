//
//  ContentView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct TodoView: View {
    // MARK: - Property Wrappers
    @State var todos = [Todos]()
    @Binding var isTodoView: Bool
    @StateObject private var todoViewModel = TodoViewModel()
    @StateObject private var firebaseManager = FirebaseManager.shared

    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    TodoListView(todos: $todos)
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            TodoAddButtonView(todos: $todos)
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        TodoMenuButtonView(
                            isConfirmationDialogAccount: $todoViewModel.isConfirmationDialogAccount,
                            dialogTitle: $todoViewModel.dialogTitle)
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
            }.confirmationDialog("\(AppConst.Text.really)\(todoViewModel.dialogTitle)\(AppConst.Text.confirmationPrompt)",
                                 isPresented: $todoViewModel.isConfirmationDialogAccount) {
                TodoConfirmationDialogButtonView(isTodoView: $isTodoView,
                                                 isSignOutFailureAlert: $todoViewModel.isFailureAlert,
                                                 dialogTitle: $todoViewModel.dialogTitle)
            }.alert("\(todoViewModel.dialogTitle)\(AppConst.Text.failed)", isPresented: $todoViewModel.isFailureAlert) {
                Button {} label: { Text(AppConst.Text.ok) }
            } message: {
                Text(AppConst.Text.retryMessage)
            }
        }
    } // body
} // view

// MARK: - Preview
struct TodoView_Previews: PreviewProvider {
    static var previews: some View {
        TodoView(isTodoView: .constant(false))
    }
}
