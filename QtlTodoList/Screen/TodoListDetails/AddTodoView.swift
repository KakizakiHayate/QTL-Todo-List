//
//  AddTodoView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct AddTodoView: View {
    // MARK: - Property Wrappers
    @State private var title = ""
    @State private var message = ""
    @State private var isTextEmpty = false
    @Binding var isTodoAddDetails: Bool
    @StateObject private var todoViewModel = TodoViewModel.shared

    // MARK: - body
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: proxy.size.height * 0.08)
                    if isTextEmpty {
                        HStack {
                            Text("タイトル又はメッセージが未入力です")
                                .foregroundColor(.red)
                                .padding(.leading)
                            Spacer()
                        }
                    }
                    TextField("タイトルが入力", text: $title)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(isTextEmpty ? Color.red : Color.gray, lineWidth: 1)
                        )
                        .padding(.top, 0)
                        .padding(.horizontal)
                    ZStack {
                        TextEditor(text: $message)
                            .frame(height: proxy.size.height / 3)
                            .border(isTextEmpty ? .red : .gray, width: 1)
                            .padding()
                        if self.message.isEmpty {
                            VStack {
                                HStack {
                                    Text("メッセージを入力")
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
                        if !title.isEmpty && !message.isEmpty {
                            todoViewModel.createFirestoreData(title: title, message: message)
                            isTodoAddDetails.toggle()
                        } else {
                            isTextEmpty = true
                        }
                    } label: {
                        Text("完了")
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
