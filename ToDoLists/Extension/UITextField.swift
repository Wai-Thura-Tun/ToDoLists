//
//  UIControl.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 12/06/2024.
//

import Foundation
import UIKit

extension UITextField {
    
    var datePicker: UIDatePicker? {
        return self.inputView as? UIDatePicker
    }
    
    func addDateTimePicker(target: Any?, selector: Selector?, dateChangeSelector: Selector) {
        let datePicker = UIDatePicker.init()
        datePicker.datePickerMode = .dateAndTime
        datePicker.minimumDate = Date.init()
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.addTarget(target, action: dateChangeSelector, for: .valueChanged)
        self.inputView = datePicker
        
        let toolBar = UIToolbar.init()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let flexiableSpace = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem.init(title: "Done", style: .done, target: target, action: selector)
        toolBar.setItems([flexiableSpace, doneBtn], animated: true)
        self.inputAccessoryView = toolBar
    }
}
