//
//  PushNotificationManager.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/09/11.
//

import SwiftUI

final class PushNotificationManager: ObservableObject {
    // MARK: - Properties
    static let shared = PushNotificationManager()
    // MARK: - init
    private init() {}
}

extension PushNotificationManager {
    // MARK: - Methods
    func sendNotificationRequest(notificationDate: Date,
                                 isNotification: Bool,
                                 title: String,
                                 message: String
    ) async {
        guard isNotification else { return }
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.defaultRingtone

        let request = UNNotificationRequest.init(
            identifier: "CalendorNotification",
            content: content,
            trigger: trigger)
        let center = UNUserNotificationCenter.current()
        do {
            try await center.add(request)
        } catch {
            print(error.localizedDescription)
        }
    }
}
