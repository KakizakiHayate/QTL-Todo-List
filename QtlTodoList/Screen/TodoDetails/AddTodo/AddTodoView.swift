//
//  AddTodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - Property Wrappers
    @Binding var isTodoAddDetails: Bool
    @StateObject private var firebaseManager = FirebaseManager.shared
    @StateObject private var addTodoViewModel = AddTodoViewModel()

    // MARK: - body
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Text(AppConst.Text.addScreen)
                        .padding()
                        .font(.title)
                    Spacer()
                        .frame(height: proxy.size.height * addTodoViewModel.topSpacing)
                    if addTodoViewModel.isTextEmpty {
                        HStack {
                            Text(AppConst.Text.emptyTitleOrMessage)
                                .foregroundColor(.red)
                                .padding(.leading)
                            Spacer()
                        }
                    }
                    TextField(AppConst.Text.inputTitle, text: $addTodoViewModel.title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(addTodoViewModel.isTextEmpty ? .red : Color.customColorEmeraldGreen.opacity(0.5), lineWidth: 1)
                        )
                        .padding(.top, 0)
                        .padding(.horizontal)
                    ZStack {
                        TextEditor(text: $addTodoViewModel.message)
                            .frame(height: proxy.size.height / 3)
                            .border(addTodoViewModel.isTextEmpty ? .red : Color.customColorEmeraldGreen.opacity(0.5), width: 1)
                            .padding()
                        if addTodoViewModel.message.isEmpty {
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
                    Button {
                        if !addTodoViewModel.title.isEmpty && !addTodoViewModel.message.isEmpty {
                        Task {
                                await firebaseManager.createFirestoreData(title: addTodoViewModel.title, message: addTodoViewModel.message)
                                isTodoAddDetails.toggle()
                            addTodoViewModel.title = AppConst.Text.empty
                            addTodoViewModel.message = AppConst.Text.empty
                            }
                        } else {
                            addTodoViewModel.isTextEmpty = true
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
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(isTodoAddDetails: .constant(false))
    }
}
