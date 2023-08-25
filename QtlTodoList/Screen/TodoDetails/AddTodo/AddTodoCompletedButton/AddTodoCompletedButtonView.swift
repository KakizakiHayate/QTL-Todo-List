//
//  AddTodoCompletedButtonView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/22.
//

import SwiftUI

struct AddTodoCompletedButtonView: View {
    // MARK: Property Wrappers
    @StateObject private var firebaseManager = FirebaseManager.shared
    @Binding var title: String
    @Binding var message: String
    @Binding var addImage: UIImage
    @Binding var isTextEmpty: Bool
    @Binding var isTodoAddDetails: Bool
    // MARK: Properties
    private let proxyWidth: CGFloat
    // MARK: init
    init(proxyWidth: CGFloat,
         title: Binding<String>,
         message: Binding<String>,
         addImage: Binding<UIImage>,
         isTextEmpty: Binding<Bool>,
         isTodoAddDetails: Binding<Bool>
    ) {
        self._title = title
        self._message = message
        self._addImage = addImage
        self._isTextEmpty = isTextEmpty
        self._isTodoAddDetails = isTodoAddDetails
        self.proxyWidth = proxyWidth
    }


    // MARK: body
    var body: some View {
        Button {
            if !title.isEmpty && !message.isEmpty {
                Task {
                    let uploadUrl = await firebaseManager.todoImageUpload(image: addImage)
                    await firebaseManager.createFirestoreData(title: title,
                                                              message: message,
                                                              imageUrl: uploadUrl)
                    isTodoAddDetails.toggle()
                    title = ""
                    message = ""
                }
            } else {
                isTextEmpty.toggle()
            }
        } label: {
            Text(AppConst.Text.completed)
                .foregroundColor(.white)
                .bold()
                .frame(width: proxyWidth / 4)
        }.padding()
            .background(Color.customColorEmeraldGreen)
            .cornerRadius(40)
    }
}

//// MARK: Preview
struct AddTodoCompletedButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoCompletedButtonView(proxyWidth: CGFloat(32),
                                   title: .constant(""),
                                   message: .constant(""),
                                   addImage: .constant(UIImage()),
                                   isTextEmpty: .constant(false),
                                   isTodoAddDetails: .constant(false))
    }
}
