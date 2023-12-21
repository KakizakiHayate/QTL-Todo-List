//
//  UpdateTodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/18.
//

import SwiftUI

class UpdateTodoViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var isTextEmpty = false
    @Published var selectedImageUpload = 0
    @Published var isLaunchCameraView = false
    @Published var isLaunchGalleryView = false
    @Published var isNotification = false
    @Published var notificationDate = Date()
    // MARK: - Properties
    let topSpacing: CGFloat = 0.08
    // MARK: - Enum
    enum SelectedAddImage: Int {
        case launchCamera = 1
        case launchGallery = 2
    }
}

// MARK: - extension
extension UpdateTodoViewModel {
    // MARK: - Methods
    func selectedImagePicker(selectedValue: Int) {
        let addImage = SelectedAddImage(rawValue: selectedValue)
        switch addImage {
        case .launchCamera:
            isLaunchCameraView.toggle()
        case .launchGallery:
            isLaunchGalleryView.toggle()
        default:
            break
        }
    }
}
