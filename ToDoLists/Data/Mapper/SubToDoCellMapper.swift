//
//  SubToDoCellMapper.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 15/06/2024.
//

import Foundation

extension SubToDoCellVO {
    func toVO() -> SubToDoVO {
        return SubToDoVO.init(
            title: self.title,
            isComplete: self.isComplete
        )
    }
}
