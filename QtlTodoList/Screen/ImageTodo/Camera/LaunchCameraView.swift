//
//  LaunchCameraView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/19.
//

import SwiftUI

/// カメラ起動
struct LaunchCameraView: UIViewControllerRepresentable {
    // MARK: - Property Wrappers
    @Binding var image: UIImage
    @Binding var isLaunchCameraView: Bool

    class Coordinator: NSObject {
        // MARK: - Properties
        let parent: LaunchCameraView
        // MARK: - init
        init(parent: LaunchCameraView) {
            self.parent = parent
        }
    }
}

// MARK: - extension
extension LaunchCameraView {
    // MARK: - Methods
    func makeCoordinator() -> Coordinator { return Coordinator(parent: self) }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()

        controller.sourceType = .camera
        controller.delegate = context.coordinator

        return controller
    }
}

// MARK: - Coordinator
extension LaunchCameraView.Coordinator: UIImagePickerControllerDelegate {
    // MARK: - Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        self.parent.image = image
        self.parent.isLaunchCameraView = false
    }
}

extension LaunchCameraView.Coordinator: UINavigationControllerDelegate {}
