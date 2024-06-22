//
//  HomeVM.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation
import UserNotifications

protocol HomeViewDelegate {
    func onLoadToDos()
    func onError(error: String)
}

class HomeVM {
    private let repository: ToDoRepository = .init()
    
    private let delegate: HomeViewDelegate
    
    private(set) var toDos: [ToDoVO] = [] {
        didSet {
            self.filteredToDos = toDos
        }
    }
    
    private(set) var filteredToDos: [ToDoVO] = [] {
        didSet {
            self.delegate.onLoadToDos()
        }
    }
    
    private(set) var searchString: String? = nil {
        didSet {
            self.searchToDos()
        }
    }
    
    init(delegate: HomeViewDelegate) {
        self.delegate = delegate
    }
    
    func setSearchString(searchString: String?) {
        self.searchString = searchString
    }
    
    func getToDos() {
        repository.getTodayToDos { todos in
            self.toDos = todos
        } onFailed: { error in
            self.delegate.onError(error: error)
        }
    }
    
    func completeToDos(for id: String) {
        repository.toggleIsCompleteToDo(for: id) {
            UNUserNotificationCenter.removeNotification(for: id)
            self.delegate.onLoadToDos()
        } onFailed: { error in
            self.delegate.onError(error: error)
        }
    }
    
    func deleteToDo(for id: String) {
        repository.deleteToDo(for: id) {
            UNUserNotificationCenter.removeNotification(for: id)
            self.delegate.onLoadToDos()
        } onFailed: { error in
            self.delegate.onError(error: error)
        }
    }
    
    private func searchToDos() {
        if searchString == nil || searchString == "" {
            self.filteredToDos = self.toDos
        }
        else {
            self.filteredToDos = self.toDos.filter { $0.title.contains(searchString ?? "") }
        }
    }
}
