//
//  SubToDoMapper.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation

extension SubToDoVO {
    func toEntity() -> SubToDoEntity {
        return SubToDoEntity.init(
            title: self.title,
            isComplete: self.isComplete
        )
    }
    
    func toCellVO() -> SubToDoCellVO {
        return SubToDoCellVO.init(
            title: self.title,
            isComplete: self.isComplete
        )
    }
}

extension SubToDoEntity {
    func toVO() -> SubToDoVO {
        return SubToDoVO.init(
            id: self.id.stringValue,
            title: self.title,
            isComplete: self.isComplete
        )
    }
}
