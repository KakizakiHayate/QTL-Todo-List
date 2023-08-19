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
    @StateObject private var updateTodoViewModel = UpdateTodoViewModel()
    @Environment(\.dismiss) private var dismiss
    @Binding var todos: Todos

    // MARK: - body
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Text(AppConst.Text.updateScreen)
                        .padding()
                        .font(.title)
                    Spacer()
                        .frame(height: proxy.size.height * updateTodoViewModel.topSpacing)
                    if updateTodoViewModel.isTextEmpty {
                        HStack {
                            Text(AppConst
                                .Text.emptyTitleOrMessage)
                                .foregroundColor(.red)
                                .padding(.leading)
                            Spacer()
                        }
                    }
                    TextField(AppConst.Text.input, text: $todos.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(updateTodoViewModel.isTextEmpty ? .red : Color.customColorEmeraldGreen.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.top, 0)
                        .padding(.horizontal)
                    ZStack {
                        TextEditor(text: $todos.message)
                            .frame(height: proxy.size.height / 3)
                            .border(updateTodoViewModel.isTextEmpty ? .red : Color.customColorEmeraldGreen.opacity(0.5), width: 1)
                            .padding()
                        if todos.message.isEmpty {
                            VStack {
                                HStack {
                                    Text(AppConst.Text.inputMessage)
                                        .opacity(0.25)
                                        .padding()
                                    Spacer()
                                }.padding(.leading, 4)
                                    .padding(.top, 10)
                                Spacer()
                            }
                        }
                    }
                    .padding(.top, 0)
                    .padding(.horizontal)
                    Button {
                        if !todos.title.isEmpty && !todos.message.isEmpty {
                            Task {
                                await firebaseManager.updateFirestoreData(todo: todos)
                                dismiss()
                            }
                        } else {
                            updateTodoViewModel.isTextEmpty.toggle()
                        }
                    } label: {
                        Text(AppConst.Text.completed)
                            .foregroundColor(.white)
                            .bold()
                            .frame(width: proxy.size.width / 4)
                    }.padding()
                        .background(Color.customColorEmeraldGreen)
                        .cornerRadius(40)
                }
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
