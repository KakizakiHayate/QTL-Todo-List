//
//  UIImageExtension.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/19.
//

import SwiftUI

// MARK: - extension
extension UIImage {
    // MARK: - Methods
    func resizeUIImage(width: CGFloat, height: CGFloat) -> UIImage? {
        // 指定された画像の大きさのコンテキストを用意.
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))

        // コンテキストに自身に設定された画像を描画する.
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))

        // コンテキストからUIImageを作る.
        let newImage = UIGraphicsGetImageFromCurrentImageContext()

        // コンテキストを閉じる.
        UIGraphicsEndImageContext()

        return newImage
    }
}
