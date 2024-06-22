//
//  UIButton.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 11/06/2024.
//

import Foundation
import UIKit

extension UIButton {
    func addShadow
    (
        opacity: Float = 0.4,
        color: UIColor = UIColor.gray,
        radius: CGFloat = 5,
        offsetWidth: CGFloat = 0,
        offsetHeight: CGFloat = 0
    ) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize.init(width: offsetWidth, height: offsetHeight)
    }
}
