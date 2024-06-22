//
//  ToDoRepository.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation

class ToDoRepository {
    private let localDataSource: ToDoLocalDataSource = .shared
    
    func getTodayToDos
    (
        onSuccess: @escaping ([ToDoVO]) -> (),
        onFailed: @escaping (String) -> ()
    )
    {
        localDataSource.getToDos { data in
            let todayToDos = data.filter {
                $0.startDate.isToday && !$0.isComplete && !$0.endDate.isOverDue
            }
            onSuccess(todayToDos)
        } onFailed: { error in
            onFailed(error)
        }

    }
    
    func getScheduledToDos
    (
        onSuccess: @escaping ([ToDoVO]) -> (),
        onFailed: @escaping (String) -> ()
    )
    {
        localDataSource.getToDos { data in
            let scheduledToDos = data.filter {
                !$0.startDate.isToday && !$0.isComplete && !$0.endDate.isOverDue
            }
            onSuccess(scheduledToDos)
        } onFailed: { error in
            onFailed(error)
        }
    }
    
    func getCompletedToDos
    (
        onSuccess: @escaping ([ToDoVO]) -> (),
        onFailed: @escaping (String) -> ()
    )
    {
        localDataSource.getToDos { data in
            let completedToDos = data.filter {
                $0.isComplete
            }
            onSuccess(completedToDos)
        } onFailed: { error in
            onFailed(error)
        }
    }
    
    func getOverdueToDos
    (
        onSuccess: @escaping ([ToDoVO]) -> (),
        onFailed: @escaping (String) -> ()
    )
    {
        localDataSource.getToDos { data in
            let overDueToDos = data.filter {
                $0.endDate.isOverDue && !$0.isComplete
            }
            onSuccess(overDueToDos)
        } onFailed: { error in
            onFailed(error)
        }
    }
    
    func createToDo(
        title: String,
        description: String,
        startDate: Date,
        endDate: Date,
        subToDos: [SubToDoVO],
        isComplete: Bool,
        isAlert: Bool,
        onSuccess: @escaping (ToDoVO) -> (),
        onFailed: @escaping (String) -> ()
    )
    {
        do {
            let todo = try localDataSource.addToDo(
                for: .init(title: title,
                           toDoDescription: description,
                           startDate: startDate,
                           endDate: endDate,
                           subToDos: subToDos,
                           isAlert: isAlert,
                           isComplete: isComplete
                          )
            )
            onSuccess(todo)
        }
        catch {
            onFailed(error.localizedDescription)
        }
    }
    
    func toggleIsCompleteToDo(
        for id: String,
        onSuccess: @escaping () -> (),
        onFailed: @escaping (String) -> ())
    {
        do {
            try localDataSource.toggleIsCompleteToDo(for: id)
            onSuccess()
        }
        catch {
            onFailed(error.localizedDescription)
        }
    }
    
    func deleteToDo(
        for id: String,
        onSuccess: @escaping () -> (),
        onFailed: @escaping (String) -> ()
    )
    {
        do {
            try localDataSource.deleteToDo(for: id)
            onSuccess()
        }
        catch {
            onFailed(error.localizedDescription)
        }
    }
    
    func updateToDo(
        for id: String,
        title: String,
        description: String,
        startDate: Date,
        endDate: Date,
        subToDos: [SubToDoVO],
        isComplete: Bool,
        isAlert: Bool,
        onSuccess: @escaping (ToDoVO) -> (),
        onFailed: @escaping (String) -> ()
    )
    {
        do {
            let todo = try localDataSource.updateToDo(
                for: .init(id: id,
                           title: title,
                           toDoDescription: description,
                           startDate: startDate,
                           endDate: endDate,
                           subToDos: subToDos,
                           isAlert: isAlert,
                           isComplete: isComplete
                          )
            )
            onSuccess(todo)
        }
        catch {
            onFailed(error.localizedDescription)
        }
    }
}
