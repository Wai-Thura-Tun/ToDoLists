//
//  HomeVM.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import Foundation

protocol HomeViewDelegate {
    func onLoadToDos()
    func onError(error: String)
}

class HomeVM {
    private let repository: ToDoRepository = .init()
    
    private let delegate: HomeViewDelegate
    
    private(set) var toDos: [ToDoVO] = [] {
        didSet {
            self.delegate.onLoadToDos()
        }
    }
    
    init(delegate: HomeViewDelegate) {
        self.delegate = delegate
    }
    
    func getToDos() {
        repository.getTodayToDos { todos in
            self.toDos = todos
            self.delegate.onLoadToDos()
        } onFailed: { error in
            self.delegate.onError(error: error)
        }
    }
}
