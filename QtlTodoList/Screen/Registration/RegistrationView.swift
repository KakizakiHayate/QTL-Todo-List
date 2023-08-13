//
//  RegistrationView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/17.
//

import SwiftUI

struct RegistrationView: View {
    // MARK: - Property Wrappers
    @Binding var isTodoView: Bool
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
                    if !registrationViewModel.name.isEmpty &&
                        !registrationViewModel.email.isEmpty &&
                        !registrationViewModel.password.isEmpty {
                        Task {
                            if await registrationViewModel.registration() {
                                isTodoView.toggle()
                            } else {
                                registrationViewModel.registrationFailureAlert.toggle()
                            }
                        }
                    } else {
                        registrationViewModel.registrationFailureAlert.toggle()
                    }
                } label: {
                    Text(AppConst.Text.registration)
                }
                .padding()
                .background(Color.customColorEmeraldGreen)
                .foregroundColor(.white)
                .font(.headline)
                .cornerRadius(30)
                .padding()
                .alert(registrationViewModel.errorMessage, isPresented: $registrationViewModel.registrationFailureAlert) {
                    Button {} label: { Text(AppConst.Text.ok) }
                } message: {
                    Text(AppConst.Text.retry)
                }
            }
            .navigationDestination(isPresented: $registrationViewModel.isTodoView) {
                TodoView(isTodoView: $isTodoView)
            }
        }
    } // body
} // view

// MARK: - Preview
struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(isTodoView: .constant(false))
    }
}
