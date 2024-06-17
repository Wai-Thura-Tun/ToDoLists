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
    @IBOutlet weak var tblToday: DynamicHeightTableView!
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
        checkDataEmpty()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.vm.getToDos()
    }
    
    private func setUpViews() {
        tblToday.register(UINib.init(nibName: "ToDoCell", bundle: nil), forCellReuseIdentifier: "ToDoCell")
        tblToday.dataSource = self
        tblToday.delegate = self
        btnAdd.addShadow(opacity: 0.8, radius: 10)
    }

    private func setUpBinding() {
        btnAdd.addTarget(self, action: #selector(onTapAdd), for: .touchUpInside)
        tfSearch.addTarget(self, action: #selector(onChangeSearchString), for: .editingChanged)
    }
    
    @objc func onChangeSearchString() {
        self.vm.setSearchString(searchString: tfSearch.text)
    }
    
    @objc func onTapAdd() {
        let vc = AddToDoVC.instantiate()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func checkDataEmpty() {
        tblToday.isHidden = self.vm.filteredToDos.count <= 0
        emptyView.isHidden = self.vm.filteredToDos.count > 0
    }
}

extension HomeVC: UITableViewDataSource {
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

extension HomeVC: UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeVC: HomeViewDelegate {
    func onLoadToDos() {
        checkDataEmpty()
        self.tblToday.reloadData()
    }
    
    func onError(error: String) {
        checkDataEmpty()
    }
}

extension HomeVC: ToDoCellDelegate {
    func onTapComplete(id: String) {
        self.vm.completeToDos(for: id)
    }
}
