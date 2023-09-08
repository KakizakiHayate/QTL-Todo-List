//
//  AppDelegate.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/09/06.
//

import Foundation
import UIKit

class AppDelegate: NSObject {}

extension AppDelegate: UIApplicationDelegate {
    // MARK: - Methods
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // 通知許可の取得
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) {
            guard $1 != nil else { return }
            $0 ? print("通知許可") : print("通知キャンセル")
        }
        return true
    }
}

//  アプリ起動中に通知を受け取ったとき
extension AppDelegate: UNUserNotificationCenterDelegate {
    // MARK: - Methods
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .banner])
    }
}
