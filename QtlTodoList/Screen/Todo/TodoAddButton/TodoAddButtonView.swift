//
//  TodoAddButtonView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import SwiftUI

struct TodoAddButtonView: View {
    // MARK: Property Wrappers
    @State private var isTodoAddDetails = false
    @StateObject private var firebaseManager = FirebaseManager.shared

    // MARK: body
    var body: some View {
        Button {
            firebaseManager.todo = Todos(title: AppConst.Text.empty, message: AppConst.Text.empty, uploadUrl: AppConst.Text.empty)
            isTodoAddDetails.toggle()
        } label: {
            Image(systemName: "pencil.tip.crop.circle.badge.plus")
                .foregroundColor(.white)
                .font(.largeTitle)
        }.frame(width: 70, height: 70)
        .background(Color.customColorEmeraldGreen)
        .cornerRadius(40)
        .padding()
        .sheet(isPresented: $isTodoAddDetails) {
            AddTodoView(isTodoAddDetails: $isTodoAddDetails)
        }
    } // body
} // view

// MARK: Preview
struct TodoAddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TodoAddButtonView()
    }
}
