//
//  TodoListDetailView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/14.
//

import SwiftUI

struct TodoListDetailView: View {
    // MARK: - Property Wrappers
    @Binding var todo: Todos
    @Binding var todos: [Todos]
    @StateObject private var firebaseManager = FirebaseManager.shared
    @StateObject private var todoListDetailViewModel = TodoListDetailViewModel()

    // MARK: - body
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text(AppConst.Text.title)
                        .font(.callout)
                        .foregroundColor(.customColorEmeraldGreen)
                        .bold()
                        .padding(.top, (UIScreen.main.bounds.height * 8) / 100)
                        .padding(.horizontal)
                    Spacer()
                }
                Text(todo.title)
                    .font(.callout)
                    .padding()
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                HStack {
                    Text(AppConst.Text.detail)
                        .font(.callout)
                        .foregroundColor(.customColorEmeraldGreen)
                        .bold()
                        .padding(.top)
                        .padding(.horizontal)
                    Spacer()
                }
                Text(todo.message)
                    .font(.caption)
                    .padding()
                    .frame(maxWidth: .infinity,
                           minHeight: UIScreen.main.bounds.height * 0.5,
                           alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                if !todo.uploadUrl.isEmpty {
                    HStack {
                        Text(AppConst.Text.photoAttached)
                            .font(.callout)
                            .foregroundColor(.customColorEmeraldGreen)
                            .bold()
                            .padding(.top)
                            .padding(.horizontal)
                        Spacer()
                    }
                    Image(uiImage: todoListDetailViewModel.todoImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }.onAppear {
                Task {
                    await firebaseManager.redraw(todos: $todos)
                    await todoListDetailViewModel.loadImage(uploadUrl: todo.uploadUrl)
                }
            }
            UpdateDetailButtonView(todos: $todo,
                                   todoImage: $todoListDetailViewModel.todoImage)
        }
    } // body
} // view

// MARK: - Preview
struct TodoListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListDetailView(todo: .constant(Todos(title: "ああああ￥", message: "testt", uploadUrl: "")),
                           todos: .constant([]))
    }
}
