//
//  TodoToolBarItemView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import SwiftUI

struct TodoMenuButtonView: View {
    // MARK: - Property Wrappers
    @Binding var isConfirmationDialogAccount: Bool
    @Binding var dialogTitle: String

    // MARK: - body
    var body: some View {
        Button(role: .destructive) {
            isConfirmationDialogAccount.toggle()
            dialogTitle = "サインアウト"
        } label: {
            Text(AppConst.Text.signOut).foregroundColor(Color.red)
        }
        Button(role: .destructive) {
            isConfirmationDialogAccount.toggle()
            dialogTitle = "退会"
        } label: {
            Text(AppConst.Text.deleteAccount).foregroundColor(Color.red)
        }
    } // body
} // view

// MARK: - Preview
struct TodoMenuButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TodoMenuButtonView(isConfirmationDialogAccount: .constant(false),
                           dialogTitle: .constant(""))
    }
}
