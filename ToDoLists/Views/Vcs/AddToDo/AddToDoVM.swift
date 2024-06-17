//
//  AddToDoVM.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 11/06/2024.
//

import Foundation
import UserNotifications

protocol AddToDoViewDelegate {
    func onLoadSubTo()
    func onValidate(validationErrors: [AddToDoVM.FormInput])
    func onSuccessAddToDo()
    func onError(error: String)
}

class AddToDoVM {
    
    enum FormInput {
        case TitleTextField(String)
        case StartDateTextField(String)
    }
    private let repository: ToDoRepository = .init()
    
    private let delegate: AddToDoViewDelegate
    
    private(set) var title: String? = nil {
        didSet {
            validate()
        }
    }
    
    private(set) var toDoDescription: String?
    
    private(set) var startDate: Date? = Date() {
        didSet {
            validate()
        }
    }
    
    private(set) var endDate: Date? = Date() {
        didSet {
            validate()
        }
    }
    
    private(set) var isAlert: Bool = true
    
    private(set) var subToDo: [SubToDoCellVO] = [] {
        didSet {
            self.delegate.onLoadSubTo()
        }
    }
    
    init(delegate: AddToDoViewDelegate) {
        self.delegate = delegate
    }
    
    func setTitle(title: String?) {
        self.title = title
    }
    
    func setToDoDescrition(description: String) {
        self.toDoDescription = description
    }
    
    func setStartDate(startDate: Date?) {
        self.startDate = startDate
    }
    
    func setEndDate(endDate: Date?) {
        self.endDate = endDate
    }
    
    func setAlert(isAlert: Bool) {
        self.isAlert = isAlert
    }
    
    func addSubToDO() {
        subToDo.append(.init())
    }
    
    func removeSubToDo(index: Int) {
        subToDo.remove(at: index)
    }
    
    func updateSubToDo(subToDos: [SubToDoVO]) {
        subToDo = subToDos.map { $0.toCellVO() }
    }
    
    func changeSubToDoComplete(data: SubToDoCellVO) {
        data.isComplete.toggle()
    }
    
    func updateSubToDoTitle(data: SubToDoCellVO, title: String) {
        data.title = title
    }
    
    func validate() {
        var errors: [FormInput] = []
        if title == nil || title == "" {
            errors.append(.TitleTextField("Title is required."))
        }
        
        if let startDate = startDate, let endDate = endDate, startDate > endDate {
            errors.append(.StartDateTextField("Start Date must not be greater than End Date"))
        }
        self.delegate.onValidate(validationErrors: errors)
    }
    
    func addToDo() {
        repository.createToDo(
            title: self.title!,
            description: self.toDoDescription ?? "",
            startDate: self.startDate!,
            endDate: self.endDate!,
            subToDos: self.subToDo.filter { !$0.title.isEmpty }.map { $0.toVO() },
            isComplete: false,
            isAlert: self.isAlert)
        { todo in
            if todo.isAlert {
                UNUserNotificationCenter.scheduleNotification(for: todo)
            }
            self.delegate.onSuccessAddToDo()
        } onFailed: { error in
            self.delegate.onError(error: error)
        }
    }
    
    func updateToDo(for id: String) {
        repository.updateToDo(
            for: id,
            title: self.title!,
            description: self.toDoDescription!,
            startDate: self.startDate!,
            endDate: self.endDate!,
            subToDos: self.subToDo.filter { !$0.title.isEmpty }.map { $0.toVO() },
            isComplete: false,
            isAlert: self.isAlert)
        { todo in
            UNUserNotificationCenter.removeNotification(for: id)
            if self.isAlert {
                UNUserNotificationCenter.scheduleNotification(for: todo)
            }
            self.delegate.onSuccessAddToDo()
        } onFailed: { error in
            self.delegate.onError(error: error)
        }
    }
}
