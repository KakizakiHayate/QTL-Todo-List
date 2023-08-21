//
//  LaunchCameraView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/19.
//

import SwiftUI

/// カメラ起動
struct LaunchCameraView: UIViewControllerRepresentable {
    // MARK: Property Wrappers
    @Binding var image: UIImage
    @Binding var isLaunchCameraView: Bool

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: LaunchCameraView
        init(parent: LaunchCameraView) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            self.parent.image = image
            self.parent.isLaunchCameraView = false
        }
    }
}

extension LaunchCameraView {
    // MARK: Methods
    func makeCoordinator() -> Coordinator { return Coordinator(parent: self) }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()

        controller.sourceType = .camera
        controller.delegate = context.coordinator

        return controller
    }
}
