//
//  SubToDoCell.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 12/06/2024.
//

import UIKit

protocol SubToDoCellDelegate: AnyObject {
    func onTapCheck(data: SubToDoCellVO)
    func onUpdateTitle(data: SubToDoCellVO, title: String)
    func onTapDelete(indexPath: IndexPath)
}

class SubToDoCell: UITableViewCell {

    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    
    var data: SubToDoCellVO? = nil {
        didSet {
            if let data = data {
                tfTitle.text = data.title
                imgCheck.image = UIImage(systemName: data.isComplete ? "checkmark.square" : "square")
            }
        }
    }
    
    weak var delegate: SubToDoCellDelegate?
    
    private var isChecked: Bool = false {
        didSet {
            imgCheck.image = UIImage(systemName: isChecked ? "checkmark.square" : "square")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        btnCheck.addTarget(self, action: #selector(onTapCheck), for: .touchUpInside)
        btnDelete.addTarget(self, action: #selector(onTapDelete), for: .touchUpInside)
        tfTitle.addTarget(self, action: #selector(onChangeTitle), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onTapCheck() {
        isChecked.toggle()
        guard let data = data else { return }
        self.delegate?.onTapCheck(data: data)
    }
    
    @objc func onChangeTitle() {
        guard let data = data else { return }
        self.delegate?.onUpdateTitle(data: data, title: tfTitle.text ?? "")
    }
    
    @objc func onTapDelete() {
        if let tableView = self.superview as? UITableView, let indexPath = tableView.indexPath(for: self) {
            self.delegate?.onTapDelete(indexPath: indexPath)
        }
    }
}
