//
//  SubToDoEntity.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation
import RealmSwift

class SubToDoEntity: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var isComplete: Bool
    
    convenience init(title: String, isComplete: Bool) {
        self.init()
        self.title = title
        self.isComplete = isComplete
    }
}
