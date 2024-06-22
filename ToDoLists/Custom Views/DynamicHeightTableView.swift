//
//  DynamicHeightTableView.swift
//  ToDoLists
//
//  Created by Wai Thura Tun on 16/06/2024.
//

import UIKit

public class DynamicHeightTableView: UITableView {
    /// set this value to value you want to limit or set to .greatestFiniteMagnitude for views that can grow larger than the phone. Default is .greatestFiniteMagnitude
    var maxHeight: CGFloat = .greatestFiniteMagnitude

    public override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }

    public override var intrinsicContentSize: CGSize {
        setNeedsLayout()
        layoutIfNeeded()
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
