//
//  HomeVC.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import UIKit

class HomeVC: UIViewController, StoryBoarded {
    
    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tblToday: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    
    static var storyboardName: String = "Home"
    
    private lazy var vm: HomeVM = .init(delegate: self)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        tabBarItem = .init(title: "Today", image: UIImage(systemName: "clock.badge.checkmark"), tag: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViews()
        setUpBinding()
        vm.getToDos()
    }
    
    private func setUpViews() {
        tblToday.register(UINib.init(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
        tblToday.dataSource = self
        tblToday.delegate = self
        btnAdd.addShadow(opacity: 0.8, radius: 10)
    }

    private func setUpBinding() {
        tfSearch.keyboardToolbar.doneBarButton.setTarget(self, action: #selector(onTapDone))
        btnAdd.addTarget(self, action: #selector(onTapAdd), for: .touchUpInside)
    }
    
    @objc func onTapDone() {
        
    }
    
    @objc func onTapAdd() {
        let vc = AddToDoVC.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoCell
        guard let cell = cell else { return UITableViewCell.init() }
        cell.data = self.vm.toDos[indexPath.row]
        return cell
    }
}

extension HomeVC: UITableViewDelegate {
    
}

extension HomeVC: HomeViewDelegate {
    func onLoadToDos() {
        self.tblToday.reloadData()
    }
    
    func onError(error: String) {
        
    }
}
