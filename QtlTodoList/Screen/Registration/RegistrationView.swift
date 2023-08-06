//
//  RegistrationView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct RegistrationView: View {
    // MARK: - Property Wrappers
    @StateObject private var registrationViewModel = RegistrationViewModel()
    // MARK: - body
    var body: some View {
        NavigationStack {
            VStack {
                TextField(AppConst.Text.inputName, text: $registrationViewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField(AppConst.Text.inputMail, text: $registrationViewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextField(AppConst.Text.inputPassword, text: $registrationViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button {
                    registrationViewModel.registration()
                } label: {
                    Text(AppConst.Text.registration)
                }
                .padding()
                .background(Color.customColorEmeraldGreen)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(30)
                .padding()
            }
            .navigationDestination(isPresented: $registrationViewModel.isTodoView) {
                TodoView()
            }
        }
    } // body
} // view

// MARK: - Preview
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
