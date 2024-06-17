//
//  AddToDoVC.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 11/06/2024.
//

import UIKit

class AddToDoVC: UIViewController, StoryBoarded {
    
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var lblTitleError: UILabel!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var tfStartDate: UITextField!
    @IBOutlet weak var tfEndDate: UITextField!
    @IBOutlet weak var swAlert: UISwitch!
    @IBOutlet weak var tblSubToDo: UITableView!
    @IBOutlet weak var heightTblSubToDo: NSLayoutConstraint!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnAddToDo: UIButton!
    
    static var storyboardName: String = "Home"
    
    private let placeholder: String = "ToDo Description (optional)"
    
    private let currentDate: Date = .init()
    
    private lazy var vm: AddToDoVM = .init(delegate: self)
    
    var data: ToDoVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpViews()
        setUpBindings()
        bindData()
    }
    
    private  func setUpViews() {
        tfStartDate.delegate = self
        tvDescription.delegate = self
        tfStartDate.text = currentDate.toString()
        tfEndDate.text = currentDate.toString()
        tblSubToDo.dataSource = self
        tblSubToDo.delegate = self
        tblSubToDo.separatorStyle = .none
        tblSubToDo.estimatedRowHeight = 55
        tblSubToDo.register(UINib.init(nibName: "SubToDoCell", bundle: nil), forCellReuseIdentifier: "SubToDoCell")
        setUpTextView()
    }
    
    private func setUpBindings() {
        tfTitle.addTarget(self, action: #selector(onChangeTitle), for: .editingChanged)
        tfStartDate.addDateTimePicker(target: self, selector: #selector(onTapStartDateDone), dateChangeSelector: #selector(onChangeStartDate))
        tfEndDate.addDateTimePicker(target: self, selector: #selector(onTapEndDateDone), dateChangeSelector: #selector(onChangeEndDate))
        swAlert.addTarget(self, action: #selector(onChangeAlert), for: .valueChanged)
        btnAdd.addTarget(self, action: #selector(onTapAddSubToDo), for: .touchUpInside)
        btnAddToDo.addTarget(self, action: #selector(onTapAddToDo), for: .touchUpInside)
    }
    
    private func setUpTextView() {
        tvDescription.text = placeholder
        tvDescription.textColor = UIColor.systemGray3
        tvDescription.layer.borderColor = UIColor.systemGray5.cgColor
        tvDescription.layer.borderWidth = 1
        tvDescription.layer.cornerRadius = 7
        tvDescription.contentInset = .init(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private func bindData() {
        if let data = data {
            tfTitle.text = data.title
            self.vm.setTitle(title: data.title)
            tvDescription.text = data.toDoDescription
            self.vm.setToDoDescrition(description: data.toDoDescription)
            tvDescription.textColor = .label
            tfStartDate.text = data.startDate.toString()
            self.vm.setStartDate(startDate: data.startDate)
            tfEndDate.text = data.endDate.toString()
            self.vm.setEndDate(endDate: data.endDate)
            self.vm.updateSubToDo(subToDos: data.subToDos)
            swAlert.isOn = data.isAlert
            self.vm.setAlert(isAlert: data.isAlert)
            self.btnAddToDo.setTitle("Update ToDo", for: .normal)
        }
    }
    
    @objc func onChangeTitle() {
        self.vm.setTitle(title: tfTitle.text)
    }
    
    @objc func onChangeStartDate() {
        tfStartDate.text = tfStartDate.datePicker?.date.toString()
        self.vm.setStartDate(startDate: tfStartDate.datePicker?.date)
    }
    
    @objc func onChangeEndDate() {
        tfEndDate.text = tfEndDate.datePicker?.date.toString()
        self.vm.setEndDate(endDate: tfEndDate.datePicker?.date)
    }
    
    @objc func onChangeAlert() {
        self.vm.setAlert(isAlert: swAlert.isOn)
    }
    
    @objc func onTapStartDateDone() {
        self.tfStartDate.resignFirstResponder()
    }
    
    @objc func onTapEndDateDone() {
        self.tfEndDate.resignFirstResponder()
    }
    
    @objc func onTapAddSubToDo() {
        vm.addSubToDO()
    }
    
    @objc func onTapAddToDo() {
        if let data = data {
            vm.updateToDo(for: data.id!)
        }
        else {
            vm.addToDo()
        }
    }
}

extension AddToDoVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.subToDo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubToDoCell", for: indexPath) as? SubToDoCell
        guard let cell = cell else { return UITableViewCell.init() }
        cell.data = vm.subToDo[indexPath.row]
        cell.delegate = self
        return cell
    }
}

extension AddToDoVC: UITableViewDelegate {
    
}

extension AddToDoVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .systemGray3 {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.vm.setToDoDescrition(description: textView.text)
    }
}

extension AddToDoVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfStartDate {
            return false
        }
        return true
    }
}

extension AddToDoVC: AddToDoViewDelegate {
    func onLoadSubTo() {
        tblSubToDo.reloadData()
        self.heightTblSubToDo.constant = self.tblSubToDo.contentSize.height
    }
    
    func onSuccessAddToDo() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func onError(error: String) {
        
    }
}

extension AddToDoVC: SubToDoCellDelegate {
    func onTapCheck(data: SubToDoCellVO) {
        vm.changeSubToDoComplete(data: data)
    }
    
    func onUpdateTitle(data: SubToDoCellVO, title: String) {
        vm.updateSubToDoTitle(data: data, title: title)
    }
    
    func onValidate(validationErrors: [AddToDoVM.FormInput]) {
        if validationErrors.isEmpty {
            btnAddToDo.isEnabled = true
            lblTitleError.isHidden = true
        }
        else {
            btnAddToDo.isEnabled = false
            validationErrors.forEach { input in
                switch input {
                case .TitleTextField(let error):
                    lblTitleError.text = error
                    lblTitleError.isHidden = false
                }
            }
        }
    }
    
    func onTapDelete(indexPath: IndexPath) {
        self.vm.removeSubToDo(index: indexPath.row)
    }
}
