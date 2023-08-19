//
//  UpdateTodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/06/24.
//

import SwiftUI

class AddTodoViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var title = ""
    @Published var message = ""
    @Published var isTextEmpty = false
    @Published var selectedImageUpload = 0
    @Published var addImage = UIImage()
    @Published var isLaunchCameraView = false
    @Published var isLaunchGalleryView = false
    // MARK: - Properties
    let topSpacing: CGFloat = 0.08

    enum AddImage: Int {
        case activateCamera = 1
        case selectionGallery = 2
    }
}

extension AddTodoViewModel {
    // MARK: Methods
    func inputBoxReset() {
        title = AppConst.Text.empty
        message = AppConst.Text.empty
    }

    func selectedImagePicker(selectedValue: Int) {
        let addImage = AddImage(rawValue: selectedValue)

        switch addImage {
        case .activateCamera:
            isLaunchCameraView.toggle()
        case .selectionGallery:
            isLaunchGalleryView.toggle()
        default:
            print("0")
        }
    }
}
