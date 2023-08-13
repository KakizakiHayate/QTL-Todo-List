//
//  ContentView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct TodoView: View {
    // MARK: - Property Wrappers
    @Binding var isTodoView: Bool
    @StateObject private var todoViewModel = TodoViewModel()
    @StateObject private var firebaseManager = FirebaseManager.shared

    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    TodoListView()
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button {
                                firebaseManager.todo = Todos(title: AppConst.Text.empty, message: AppConst.Text.empty)
                                todoViewModel.isTodoAddDetails.toggle()
                            } label: {
                                Image(systemName: "pencil.tip.crop.circle.badge.plus")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                            }.frame(width: 70, height: 70)
                            .background(Color.customColorEmeraldGreen)
                            .cornerRadius(40)
                            .padding()
                            .sheet(isPresented: $todoViewModel.isTodoAddDetails) {
                                AddTodoView(isTodoAddDetails: $todoViewModel.isTodoAddDetails)
                            }
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(role: .destructive) {
                            todoViewModel.isConfirmationSignOut.toggle()
                        } label: {
                            Text("サインアウトする").foregroundColor(Color.red)
                        }
                    } label: {
                        Image(systemName: "person.fill")
                    }
                }
            }.confirmationDialog("本当にサインアウトしてもよろしいですか？", isPresented: $todoViewModel.isConfirmationSignOut) {
                Button(role: .destructive) {
                    Task {
                        if await todoViewModel.signOut() {
                            isTodoView.toggle()
                        } else {
                            todoViewModel.isSignOutFailureAlert.toggle()
                        }
                    }
                } label: {
                    Text("サインアウトする")
                }
                Button(role: .cancel) {} label: { Text("キャンセル") }
            }.alert("サインアウトに失敗しました", isPresented: $todoViewModel.isSignOutFailureAlert) {
                Button {} label: { Text(AppConst.Text.ok) }
            } message: {
                Text("しばらくしてから再度お試しください")
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
