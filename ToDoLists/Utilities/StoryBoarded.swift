//
//  StoryBoarded.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation

protocol StoryBoarded: AnyObject {
    static var storyboardName: String { get set }
    static func instantiate(bundle: Bundle) -> Self
}

extension StoryBoarded {
    static func instantiate(bundle: Bundle) -> Self {
        
    }
}
