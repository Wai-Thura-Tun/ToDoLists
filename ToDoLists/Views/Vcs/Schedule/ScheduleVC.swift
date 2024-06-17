//
//  ScheduleVC.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 10/06/2024.
//

import UIKit

class ScheduleVC: UIViewController, StoryBoarded {

    @IBOutlet weak var tfSearch: UITextField!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tblScheduled: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    
    static var storyboardName: String = "Home"
    
    private lazy var vm: ScheduleVM = .init(delegate: self)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        tabBarItem = .init(
            title: "Scheduled",
            image: UIImage(systemName: "timer.circle"),
            tag: 2
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViews()
        setUpBinding()
        checkDataEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.vm.getToDos()
    }
    
    private func setUpViews() {
        tblScheduled.register(UINib.init(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
        tblScheduled.dataSource = self
        tblScheduled.delegate = self
        btnAdd.addShadow(opacity: 0.8, radius: 10)
    }
    
    private func setUpBinding() {
        tfSearch.addTarget(self, action: #selector(onChangeSearchString), for: .editingChanged)
        btnAdd.addTarget(self, action: #selector(onTapAdd), for: .touchUpInside)
    }
    
    @objc func onChangeSearchString() {
        self.vm.setSearchString(searchString: tfSearch.text)
    }
    
    @objc func onTapAdd() {
        let vc = AddToDoVC.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func checkDataEmpty() {
        tblScheduled.isHidden = self.vm.filteredToDos.count <= 0
        emptyView.isHidden = self.vm.filteredToDos.count > 0
    }
}

extension ScheduleVC: UITableViewDataSource {
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

extension ScheduleVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.vm.deleteToDo(for: self.vm.filteredToDos[indexPath.row].id!)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddToDoVC.instantiate()
        vc.data = self.vm.filteredToDos[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ScheduleVC: ScheduleViewDelegate {
    func onLoadToDos() {
        checkDataEmpty()
        self.tblScheduled.reloadData()
    }
    
    func onError(error: String) {
        checkDataEmpty()
    }
}

extension ScheduleVC: ToDoCellDelegate {
    func onTapComplete(id: String) {
        self.vm.completeToDos(for: id)
    }
}

