//
//  ToDoVO.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation

struct ToDoVO {
    var id: String?
    let title: String
    let toDoDescription: String
    let startDate: Date
    let endDate: Date
    let subToDos: [SubToDoVO]
    let isAlert: Bool
    let isComplete: Bool
}
