//
//  ShowSubToDoCell.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 16/06/2024.
//

import UIKit

class ShowSubToDoCell: UITableViewCell {

    @IBOutlet weak var imgCheck: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    var data: SubToDoVO? = nil {
        didSet {
            if let data = data {
                imgCheck.image = UIImage(systemName: data.isComplete ? "checkmark.square" : "checkmark.square")
                lblTitle.text = data.title
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
