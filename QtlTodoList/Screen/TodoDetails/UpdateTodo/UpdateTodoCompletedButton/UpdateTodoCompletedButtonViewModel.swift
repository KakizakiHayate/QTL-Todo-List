//
//  UpdateTodoCompletedButtonViewModel.swift
//  QtlTodoList
//
//  Created by 柿崎逸 on 2023/09/06.
//

import Foundation
import SwiftUI

class UpdateTodoCompletedButtonViewModel: ObservableObject {
    // MARK: - Property Wrappers
    @ObservedObject private var firebaseManager = FirebaseManager.shared
}

extension UpdateTodoCompletedButtonViewModel {
    // MARK: - Methods
    func imageUploadAndUpdateTodo(todoImage: UIImage, todos: Todos) async {
        let uploadUrl = await firebaseManager.todoImageUpload(image: todoImage)
        await firebaseManager.updateFirestoreData(todo: todos, uploadUrl: uploadUrl)
    }

    func sendNotificationRequest(notificationDate: Date,
                                 isNotification: Bool,
                                 title: String,
                                 message: String
    ) async {
        guard isNotification else { return }
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notificationDate)
        print(triggerDate)
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
