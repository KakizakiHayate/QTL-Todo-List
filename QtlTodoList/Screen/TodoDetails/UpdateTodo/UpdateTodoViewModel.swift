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
    // MARK: - Properties
    let topSpacing: CGFloat = 0.08
    // MARK: - Enum
    enum SelectedAddImage: Int {
        case LaunchCamera = 1
        case LaunchGallery = 2
    }
}

// MARK: - extension
extension UpdateTodoViewModel {
    // MARK: - Methods
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
