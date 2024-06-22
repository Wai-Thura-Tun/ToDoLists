//
//  OverdueVC.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import UIKit

class OverdueVC: UIViewController, StoryBoarded {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tblOverdue: UITableView!
    
    static var storyboardName: String = "Home"
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        tabBarItem = .init(
            title: "Overdue",
            image: UIImage(systemName: "clock.badge.exclamationmark"),
            tag: 3
        )
    }
    
    private lazy var vm: OverdueVM = .init(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpViews()
        setUpBinding()
        checkDataEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        vm.getToDos()
    }
    
    private func setUpViews() {
        tblOverdue.register(UINib.init(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
        tblOverdue.dataSource = self
        tblOverdue.delegate = self
    }
    
    private func setUpBinding() {
        tfSearch.addTarget(self, action: #selector(onChangeSearchString), for: .editingChanged)
    }
    
    @objc func onChangeSearchString() {
        self.vm.setSearchString(searchString: tfSearch.text)
    }
    
    private func checkDataEmpty() {
        tblOverdue.isHidden = self.vm.filteredToDos.count <= 0
        emptyView.isHidden = self.vm.filteredToDos.count > 0
    }
}

extension OverdueVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.filteredToDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as? ToDoCell
        guard let cell = cell else { return UITableViewCell.init() }
        cell.data = self.vm.filteredToDos[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension OverdueVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.vm.deleteToDo(for: self.vm.filteredToDos[indexPath.row].id!)
        }
    }
}

extension OverdueVC: OverdueViewDelegate {
    func onLoadToDos() {
        checkDataEmpty()
        self.tblOverdue.reloadData()
    }
        
    func onError(error: String) {
        checkDataEmpty()
    }
}
    
extension OverdueVC: ToDoCellDelegate {
    func onTapComplete(id: String) {
        self.vm.completeToDos(for: id)
    }
}

