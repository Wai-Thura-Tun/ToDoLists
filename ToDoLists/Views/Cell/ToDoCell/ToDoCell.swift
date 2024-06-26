//
//  ToDoCell.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 11/06/2024.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func onTapComplete(id: String)
}

class ToDoCell: UITableViewCell {

    @IBOutlet weak var vMain: UIView!
    //@IBOutlet weak var vMoreSubToDo: UIView!
    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var vDescription: UIView!
//    @IBOutlet weak var tblSubToDo: UITableView!
//    @IBOutlet weak var heightTblSubToDo: NSLayoutConstraint!
    @IBOutlet weak var lblDate: UILabel!
    
    var data: ToDoVO? = nil {
        didSet {
            if let data = data {
                imgCheck.image = UIImage(systemName: data.isComplete ? "circle.circle.fill" : "circle")
                lblTitle.text = data.title
                lblDescription.text = data.toDoDescription
                vDescription.isHidden = data.toDoDescription.isEmpty
                //vMoreSubToDo.isHidden = data.subToDos.count <= 3
                //tblSubToDo.isHidden = data.subToDos.isEmpty
//                if !data.subToDos.isEmpty {
//                    tblSubToDo.reloadData()
//                    tblSubToDo.beginUpdates()
//                    self.heightTblSubToDo.constant = self.tblSubToDo.contentSize.height
//                    tblSubToDo.endUpdates()
//                }
                lblDate.text = data.startDate.toString()
            }
        }
    }
    
    weak var delegate: ToDoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        setUpViews()
        setUpBindings()
    }
    
    private func setUpViews() {
//        tblSubToDo.register(UINib.init(nibName: "ShowSubToDoCell", bundle: nil), forCellReuseIdentifier: "ShowSubToDoCell")
//        tblSubToDo.dataSource = self
//        tblSubToDo.delegate = self
//        tblSubToDo.rowHeight = UITableView.automaticDimension
//        tblSubToDo.estimatedRowHeight = 22
        vMain.layer.shadowOpacity = 0.3
        vMain.layer.shadowColor = UIColor.gray.cgColor
        vMain.layer.shadowRadius = 7
    }
    
    private func  setUpBindings() {
        btnCheck.addTarget(self, action: #selector(onTapComplete), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onTapComplete() {
        guard let data = data else { return }
        self.delegate?.onTapComplete(id: data.id!)
    }
}

//extension ToDoCell: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return min(3, data?.subToDos.count ?? 0)
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowSubToDoCell", for: indexPath) as? ShowSubToDoCell
//        guard let cell = cell else { return UITableViewCell.init() }
//        cell.data = data?.subToDos[indexPath.row]
//        return cell
//    }
//}

extension ToDoCell: UITableViewDelegate {
}
