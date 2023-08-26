//
//  TodoListDetailViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/19.
//

import SwiftUI

class TodoListDetailViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var todoImage = UIImage()
    // MARK: - Properties
    let equalSpacing: CGFloat = 2
}

// MARK: - extension
extension TodoListDetailViewModel {
    // MARK: - Methods
    func loadImage(uploadUrl: String) async {
        guard let url = URL(string: uploadUrl) else { return }
        do {
            let (data, _)  = try await URLSession.shared.data(from: url)
            Task { @MainActor in
                todoImage = UIImage(data: data) ?? UIImage()
            }
        } catch {
            print(error.localizedDescription)
            return
        }
    }
}
