//
//  UNUserNotification.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 17/06/2024.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    static func scheduleNotification(for toDo: ToDoVO) {
        let appName = (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
        let content = UNMutableNotificationContent.init()
        content.title = appName
        content.body = toDo.title
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: toDo.startDate)
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: triggerDate, repeats: false)
        guard let identifier = toDo.id else { return }
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        self.current().add(request)
    }
    
    static func removeNotification(for id: String?) {
        if let identitifer = id {
            self.current().removePendingNotificationRequests(withIdentifiers: [identitifer])
        }
    }
}
