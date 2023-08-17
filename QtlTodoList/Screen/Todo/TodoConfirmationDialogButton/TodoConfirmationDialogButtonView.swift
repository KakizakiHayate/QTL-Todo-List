//
//  TodoConfirmationDialogButtonView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import SwiftUI

struct TodoConfirmationDialogButtonView: View {
    // MARK: Property Wrappers
    @Binding var isTodoView: Bool
    @Binding var isSignOutFailureAlert: Bool
    @Binding var dialogTitle: String
    @StateObject private var todoConfirmationDialogButtonViewModel = TodoConfirmationDialogButtonViewModel()

    // MARK: body
    var body: some View {
        Button(role: .destructive) {
            Task {
                switch dialogTitle {
                case "サインアウト":
                    await todoConfirmationDialogButtonViewModel.signOut() ?
                    isTodoView.toggle() : isSignOutFailureAlert.toggle()
                case "退会":
                    await todoConfirmationDialogButtonViewModel.deleteAccount() ?
                    isTodoView.toggle() : isSignOutFailureAlert.toggle()
                default:
                    print("default")
                    break
                }
            }
        } label: {
            Text("\(dialogTitle)\(AppConst.Text.actionInfo)")
        }
        Button(role: .cancel) {} label: { Text(AppConst.Text.cancel) }
    } // body
} // view

// MARK: Preview
struct TodoConfirmationDialogButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TodoConfirmationDialogButtonView(isTodoView: .constant(false),
                                         isSignOutFailureAlert: .constant(false),
                                         dialogTitle: .constant(""))
    }
}
