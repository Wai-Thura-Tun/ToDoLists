//
//  TabBarVC.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import UIKit

class TabBarVC: UITabBarController {

    private var homeVC: HomeVC {
        return HomeVC.instantiate()
    }
    
    private var scheduleVC: ScheduleVC {
        return ScheduleVC.instantiate()
    }
    
    private var overdueVC: OverdueVC {
        return OverdueVC.instantiate()
    }
    
    private var allToDosVC: CompleteVC {
        return CompleteVC.instantiate()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            homeVC,
            scheduleVC,
            overdueVC,
            allToDosVC
        ]
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor.systemBackground
        tabBar.tintColor = UIColor(named: "ThemeColor")
    }
}
