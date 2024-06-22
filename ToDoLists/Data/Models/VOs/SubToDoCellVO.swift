//
//  SubToDoCellVO.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 15/06/2024.
//

import Foundation

class SubToDoCellVO {
    var title: String = ""
    var isComplete: Bool = false
    
    convenience init(title: String, isComplete: Bool) {
        self.init()
        self.title = title
        self.isComplete = isComplete
    }
}
