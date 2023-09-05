//
//  FirebaseError.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/08/12.
//

import Foundation

// MARK: - Enum
enum FirebaseAuthError: Error {
    case networkError
    case weakPassword
    case wrongPassword
    case userNotFound
    case invalidEmail
    case emailAlreadyInUse
    case unknown

    // MARK: - Properties
    var title: String {
        switch self {
        case .networkError:
            return "通信エラーです。"
        case .weakPassword:
            return "パスワードが脆弱です。"
        case .wrongPassword:
            return "メールアドレス、もしくはパスワードが違います。"
        case .userNotFound:
            return "アカウントがありません。"
        case .invalidEmail:
            return "正しくないメールアドレスの形式です。"
        case .emailAlreadyInUse:
            return "既に登録されているメールアドレスです。"
        case .unknown:
            return "予期せぬエラーが起きました。"
        }
    }
}
