//
//  RootNC.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation
import UIKit

class RootNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToTabBar()
    }
    
    func goToTabBar() {
        let tabBarVC = TabBarVC.init()
        self.setViewControllers([tabBarVC], animated: true)
    }
}
