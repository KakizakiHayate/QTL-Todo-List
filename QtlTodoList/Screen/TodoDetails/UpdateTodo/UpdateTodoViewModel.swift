//
//  UpdateTodoViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/18.
//

import Foundation

class UpdateTodoViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @Published var isTextEmpty = false
    // MARK: - Properties
    let topSpacing: CGFloat = 0.08
}
