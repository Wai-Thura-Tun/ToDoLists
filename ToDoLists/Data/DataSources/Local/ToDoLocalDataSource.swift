//
//  ToDoLocalDataSource.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation
import RealmSwift

class ToDoLocalDataSource {
    
    static let shared: ToDoLocalDataSource = .init()
    
    private let realm: Realm
    
    private var realmChangeListener: NotificationToken?
    
    private init() {
        realm = try! Realm()
    }
    
    func addToDo(for todo: ToDoVO) throws -> ToDoVO {
        let todo = todo.toEntity()
        try realm.write {
            realm.add(todo, update: .all)
        }
        return todo.toVO()
    }
    
    func getToDos
    (
        onSuccess: @escaping ([ToDoVO]) -> (),
        onFailed: @escaping (String) -> ()
    )
    {
        realmChangeListener = realm.objects(ToDoEntity.self).observe { (change: RealmCollectionChange) in
            switch change {
            case .initial(let results):
                onSuccess(results.map { $0.toVO() })
            case .update(let results, _, _, _):
                onSuccess(results.map { $0.toVO() })
            case .error(let error):
                onFailed(error.localizedDescription)
            }
        }
    }
    
    func toggleIsCompleteToDo(for id: String) throws {
        let objectId = try ObjectId(string: id)
        if let object = realm.object(ofType: ToDoEntity.self, forPrimaryKey: objectId) {
            try realm.write {
                object.isComplete.toggle()
                object.subToDos.forEach { $0.isComplete.toggle() }
            }
        }
    }
    
    func deleteToDo(for id: String) throws {
        let objectId = try ObjectId(string: id)
        if let object = realm.object(ofType: ToDoEntity.self, forPrimaryKey: objectId) {
            try realm.write {
                realm.delete(object)
            }
        }
    }
    
    func updateToDo(for todo: ToDoVO) throws -> ToDoVO {
        let objectId = try ObjectId(string: todo.id!)
        if let object = realm.object(ofType: ToDoEntity.self, forPrimaryKey: objectId) {
            try realm.write {
                object.title = todo.title
                object.toDoDescription = todo.toDoDescription
                object.startDate = todo.startDate
                object.endDate = todo.endDate
                object.subToDos = todo.toEntity().subToDos
                object.isAlert = todo.isAlert
            }
        }
        return todo;
    }
}
