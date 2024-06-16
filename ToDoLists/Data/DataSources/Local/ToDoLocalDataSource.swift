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
    
    func addToDo(for todo: ToDoVO) throws {
        try realm.write {
            realm.add(todo.toEntity(), update: .all)
        }
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
}
