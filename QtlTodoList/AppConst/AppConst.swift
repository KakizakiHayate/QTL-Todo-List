//
//  AppConst.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/07/01.
//

import Foundation

enum AppConst {
    enum Text {
        static let registration = "新規登録する"
        static let inputName = "名前を入力"
        static let inputMail = "メールアドレスを入力"
        static let inputPassword = "パスワードを入力"
        static let inputTitle = "タイトルを入力"
        static let inputMessage = "メッセージを入力"
        static let login = "ログインする"
        static let googleLogin = "Googleログイン"
        static let newRegistration = "新規登録"
        static let addScreen = "追加画面"
        static let updateScreen = "更新画面"
        static let empty = ""
        static let emptyTitleOrMessage = "タイトル又はメッセージが未入力です"
        static let completed = "完了"
        static let input = "入力"
        static let deleteTask = "このタスクを削除しますか？"
        static let cancel = "キャンセル"
        static let ok = "OK"
        static let registrationFailure = "新規登録に失敗しました"
        static let retry = "入力内容を確認して再試行してください"
        static let loginFailure = "ログインに失敗しました"
        static let googleLoginFailure = "Googleログインに失敗しました"
        static let signOut = "サインアウトする"
        static let deleteAccount = "退会する"
        static let retryMessage = "しばらくしてから再度お試しください"
        static let failed = "に失敗しました"
        static let really = "本当に"
        static let confirmationPrompt = "してもよろしいですか？"
        static let actionInfo = "する"
    }
    enum separatorText {
        static let or = "--- または ---"
        static let notRegistered = "--- 登録されてない方はコチラ ---"
    }
}
