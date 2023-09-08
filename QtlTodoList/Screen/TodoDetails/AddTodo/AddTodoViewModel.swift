//
//  UpdateTodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/24.
//

import SwiftUI
import FirebaseStorage

class AddTodoViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var title = ""
    @Published var message = ""
    @Published var isTextEmpty = false
    @Published var selectedImageUpload = 0
    @Published var addImage = UIImage()
    @Published var isLaunchCameraView = false
    @Published var isLaunchGalleryView = false
    @Published var isNotification = false
    @Published var notificationDate = Date()

    // MARK: - Properties
    let topSpacing: CGFloat = 0.08
    let storage = Storage.storage()

    // MARK: - Enum
    enum SelectedAddImage: Int {
        case LaunchCamera = 1
        case LaunchGallery = 2
    }
}

// MARK: - extension
extension AddTodoViewModel {
    // MARK: - Methods
    func inputBoxReset() {
        title = AppConst.Text.empty
        message = AppConst.Text.empty
    }

    func selectedImagePicker(selectedValue: Int) {
        let addImage = SelectedAddImage(rawValue: selectedValue)
        switch addImage {
        case .LaunchCamera:
            isLaunchCameraView.toggle()
        case .LaunchGallery:
            isLaunchGalleryView.toggle()
        default:
            break
        }
    }
}
