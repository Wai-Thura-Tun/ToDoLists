//
//  StoryBoarded.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation
import UIKit

protocol StoryBoarded: AnyObject {
    static var storyboardName: String { get set }
    static func instantiate(bundle: Bundle) -> Self
}

extension StoryBoarded {
    static func instantiate(bundle: Bundle = Bundle.main) -> Self {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as! Self
    }
}
