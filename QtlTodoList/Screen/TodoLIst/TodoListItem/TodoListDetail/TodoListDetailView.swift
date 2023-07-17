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
    // MARK: - Properties
    private let equalSpacing: CGFloat = 2

    // MARK: - body
    var body: some View {
        VStack {
            GeometryReader { proxy in
                let frameWidth = proxy.size.width / 1.3
                Text(todos.title)
                    .font(.callout)
                    .padding()
                    .frame(width: frameWidth,
                           alignment: .leading)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                    .offset(x: (proxy.size.width - (frameWidth)) / equalSpacing,
                            y: UIScreen.main.bounds.height * 0.03)
                Text(todos.message)
                    .font(.caption)
                    .padding()
                    .frame(width: frameWidth,
                           height: UIScreen.main.bounds.height * 0.5,
                           alignment: .topLeading)
                    .background(.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.7), radius: 5)
                    .offset(x: (proxy.size.width - (frameWidth)) / equalSpacing,
                            y: UIScreen.main.bounds.height * 0.2)
            }
            UpdateDeleteButtonView(todos: $todos)
        }
    } // body
} // view

// MARK: - Preview
struct TodoListDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListDetailView(todos: .constant(Todos(title: "ああああ￥", message: "testt")))
    }
}
