//
//  Date.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation

extension Date {
    var isToday: Bool {
        let component = Calendar.current.dateComponents([.day], from: self)
        let currentComponent = Calendar.current.dateComponents([.day], from: Date())
        return component.day == currentComponent.day
    }
    
    var isOverDue: Bool {
        return self > Date()
    }
    
    func toString(format: String = "h:mm a") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if self.isToday {
            dateFormatter.dateFormat = "h:mm a"
            return "Today, \(dateFormatter.string(from: self))"
        }
        else {
            dateFormatter.dateFormat = "MMM DD, h:mm a"
            return dateFormatter.string(from: self)
        }
    }
}
