//
//  OverviewCell.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 10. 21..
//  Copyright © 2019. WUP. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {
    
    @IBOutlet weak var propLbl: UILabel!
    @IBOutlet weak var curLbl: UILabel!
    @IBOutlet weak var valueLbl: UILabel!
    
    
    func addCell(title property:String, curreny cur:String?, value:String) {
        propLbl.text = property
        if cur != nil {
            curLbl.text = cur
        } else {
            curLbl.isHidden = true
        }
        valueLbl.text = value
    }
        
}
