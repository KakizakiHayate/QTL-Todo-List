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
                    } else {
                        // 処理しない
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
                        } else {
                            // 処理しない
                        }
                    }
                    if addTodoViewModel.addImage.size != .zero {
                        Image(uiImage: addTodoViewModel.addImage)
                            .resizable()
                            .frame(width: 300, height: 300)
                    } else {
                        // 処理しない
                    }
                    Picker(AppConst.Text.empty, selection: $addTodoViewModel.selectedImageUpload) {
                        Text(AppConst.Text.launchCamera).tag(1)
                        Text(AppConst.Text.launchGallery).tag(2)
                    }.padding()
                        .onChange(of: addTodoViewModel.selectedImageUpload) { newValue in
                            addTodoViewModel.selectedImagePicker(selectedValue: newValue)
                            addTodoViewModel.selectedImageUpload = 0
                        }.sheet(isPresented: $addTodoViewModel.isLaunchCameraView) {
                            LaunchCameraView(image: $addTodoViewModel.addImage,
                                             isLaunchCameraView: $addTodoViewModel.isLaunchCameraView)
                        }.sheet(isPresented: $addTodoViewModel.isLaunchGalleryView) {
                            LaunchGalleryView(image: $addTodoViewModel.addImage,
                                              isLaunchGalleryView: $addTodoViewModel.isLaunchGalleryView)
                        }
                    Toggle(isOn: $addTodoViewModel.isNotification, label: {
                        Text("\(AppConst.Text.notification)\(addTodoViewModel.isNotification ? AppConst.Text.do : AppConst.Text.doNot)")
                    }).padding()
                    if addTodoViewModel.isNotification {
                        DatePicker(AppConst.Text.selectDateAndTime,
                                   selection: $addTodoViewModel.notificationDate)
                        .environment(\.locale, Locale(identifier: "ja_JP"))
                        .environment(\.calendar, Calendar(identifier: .japanese))
                        .padding()
                        .padding(.bottom, 32)
                    } else {
                        // 処理しない
                    }
                    AddTodoCompletedButtonView(proxyWidth: proxy.size.height,
                                               title: $addTodoViewModel.title,
                                               message: $addTodoViewModel.message,
                                               addImage: $addTodoViewModel.addImage,
                                               isTextEmpty: $addTodoViewModel.isTextEmpty,
                                               isTodoAddDetails: $isTodoAddDetails,
                                               notificationDate: $addTodoViewModel.notificationDate,
                                               isNotification: $addTodoViewModel.isNotification)
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
