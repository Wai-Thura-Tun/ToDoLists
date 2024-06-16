//
//  AllTasksVC.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import UIKit

class CompleteVC: UIViewController, StoryBoarded {

    static var storyboardName: String = "Home"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        tabBarItem = .init(
            title: "Completed",
            image: UIImage(systemName: "checkmark.seal"),
            tag: 4
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
