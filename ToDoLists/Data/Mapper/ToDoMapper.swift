//
//  ToDoMapper.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation

extension ToDoVO {
    func toEntity() -> ToDoEntity {
        return ToDoEntity.init(
            title: self.title,
            toDoDescription: self.toDoDescription,
            startDate: self.startDate,
            endDate: self.endDate,
            subToDos: self.subToDos, 
            isAlert: self.isAlert,
            isComplete: self.isComplete
        )
    }
}

extension ToDoEntity {
    func toVO() -> ToDoVO {
        return ToDoVO.init(
            id: self.id.stringValue,
            title: self.title,
            toDoDescription: self.toDoDescription,
            startDate: self.startDate,
            endDate: self.endDate,
            subToDos: self.subToDos.map { $0.toVO() }, 
            isAlert: self.isAlert,
            isComplete: self.isComplete
        )
    }
}

