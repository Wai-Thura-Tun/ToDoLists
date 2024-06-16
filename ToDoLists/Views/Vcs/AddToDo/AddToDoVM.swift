//
//  AddToDoVM.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 11/06/2024.
//

import Foundation

protocol AddToDoViewDelegate {
    func onLoadSubTo()
    func onValidate(validationErrors: [AddToDoVM.FormInput])
    func onSuccessAddToDo()
    func onError(error: String)
}

class AddToDoVM {
    
    enum FormInput {
        case TitleTextField(String)
    }
    private let repository: ToDoRepository = .init()
    
    private let delegate: AddToDoViewDelegate
    
    private(set) var title: String? = nil {
        didSet {
            validate()
        }
    }
    
    private(set) var toDoDescription: String?
    
    private(set) var startDate: Date? = Date()
    
    private(set) var endDate: Date? = Date()
    
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
        self.delegate.onValidate(validationErrors: errors)
    }
    
    func addToDo() {
        repository.createToDo(
            title: self.title!,
            description: self.toDoDescription ?? "",
            startDate: self.startDate!,
            endDate: self.endDate!,
            subToDos: self.subToDo.map { $0.toVO() },
            isComplete: false,
            isAlert: self.isAlert)
        {
            self.delegate.onSuccessAddToDo()
        } onFailed: { error in
            self.delegate.onError(error: error)
        }
    }
}
