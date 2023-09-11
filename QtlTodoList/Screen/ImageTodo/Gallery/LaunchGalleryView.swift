//
//  LaunchGalleryView.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/19.
//

import SwiftUI
import PhotosUI

struct LaunchGalleryView: UIViewControllerRepresentable {
    // MARK: - Property Wrappers
    @Binding var image: UIImage
    @Binding var isLaunchGalleryView: Bool

    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        // MARK: - Properties
        let parent: LaunchGalleryView
        // MARK: - init
        init(parent: LaunchGalleryView) {
            self.parent = parent
        }

        // MARK: - Methods
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            self.parent.isLaunchGalleryView = false

            guard let itemProvider = results.first?.itemProvider else { return }
            guard itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                guard let image = image as? UIImage else {
                    return
                }
                Task { @MainActor in
                    self?.parent.image = image
                }
            }
        }
    }
}

// MARK: - extension
extension LaunchGalleryView {
    // MARK: - Methods
    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }

    func makeUIViewController(context: UIViewControllerRepresentableContext<LaunchGalleryView>) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()

        configuration.filter = .images
        configuration.selectionLimit = 1
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController,
                                context: UIViewControllerRepresentableContext<LaunchGalleryView>) {}
}

