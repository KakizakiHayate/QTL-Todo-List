//
//  ViewExtension.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/13.
//

import Foundation
import SwiftUI

extension View {
    // MARK: Methods
    func getRootViewController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }

        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        return root
    }
}
