//
//  ToDoEntity.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation
import RealmSwift

class ToDoEntity: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var toDoDescription: String
    @Persisted var startDate: Date
    @Persisted var endDate: Date
    @Persisted var subToDos: List<SubToDoEntity>
    @Persisted var isAlert: Bool
    @Persisted var isComplete: Bool
    
    convenience init(title: String, toDoDescription: String, startDate: Date, endDate: Date, subToDos: [SubToDoVO], isAlert: Bool, isComplete: Bool) {
        self.init()
        self.title = title
        self.toDoDescription = toDoDescription
        self.startDate = startDate
        self.endDate = endDate
        self.subToDos.append(objectsIn: subToDos.map { $0.toEntity() } )
        self.isAlert = isAlert
        self.isComplete = isComplete
    }
}
