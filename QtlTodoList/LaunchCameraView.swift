//
//  LaunchCameraView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/17.
//

import SwiftUI

/// カメラ起動
struct LaunchCameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage
    @Binding var isLaunchCameraView: Bool

    func makeCoordinator() -> Coordinator { return Coordinator(parent: self) }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let controller = UIImagePickerController()

        controller.sourceType = .camera
        controller.delegate = context.coordinator

        return controller
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        let parent: LaunchCameraView

        init(parent: LaunchCameraView) {
            self.parent = parent
        }
        // 写真を選択したときに呼ばれるメソッド
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print("imagePicker")
            guard let image = info[.originalImage] as? UIImage else {
                return
            }
            self.parent.image = image
            self.parent.isLaunchCameraView = false
        }
    }
}
