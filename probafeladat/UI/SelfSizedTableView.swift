//
//  SelfSizedTableView.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 12. 16..
//  Copyright © 2019. WUP. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {

    var maxHeight: CGFloat = UIScreen.main.bounds.height

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
    }
    
    override var intrinsicContentSize: CGSize {
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
}
