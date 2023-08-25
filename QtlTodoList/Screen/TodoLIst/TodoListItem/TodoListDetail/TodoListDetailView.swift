//
//  TodoListDetailView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/14.
//

import SwiftUI

struct TodoListDetailView: View {
    // MARK: - Property Wrappers
    @Binding var todos: Todos
    @StateObject private var firebaseManager = FirebaseManager.shared
    @StateObject private var todoListDetailViewModel = TodoListDetailViewModel()

    // MARK: - body
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("タイトル")
                        .font(.callout)
                        .foregroundColor(.customColorEmeraldGreen)
                        .bold()
                        .padding(.top, (UIScreen.main.bounds.height * 8) / 100)
                        .padding(.horizontal)
                    Spacer()
                }
                Text(todos.title)
                    .font(.callout)
                    .padding()
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                HStack {
                    Text("詳細")
                        .font(.callout)
                        .foregroundColor(.customColorEmeraldGreen)
                        .bold()
                        .padding(.top)
                        .padding(.horizontal)
                    Spacer()
                }
                Text(todos.message)
                    .font(.caption)
                    .padding()
                    .frame(maxWidth: .infinity,
                           minHeight: UIScreen.main.bounds.height * 0.5,
                           alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                if !todos.uploadUrl.isEmpty {
                    HStack {
                        Text("添付された画像")
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
                    await todoListDetailViewModel.loadImage(uploadUrl: todos.uploadUrl)
                }
            }
            UpdateDetailButtonView(todos: $todos,
                                   todoImage: $todoListDetailViewModel.todoImage)
        }
    } // body
} // view

// MARK: - Preview
struct TodoListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListDetailView(todos: .constant(Todos(title: "ああああ￥", message: "testt", uploadUrl: "")))
    }
}
