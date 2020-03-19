//
//  ArrowButton.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2019. 12. 19..
//  Copyright © 2019. WUP. All rights reserved.
//

import UIKit

class ArrowButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        let origImage = UIImage(named: "ic_arrowleft.png")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        setImage(tintedImage, for: .normal)
        tintColor = #colorLiteral(red: 0.3254901961, green: 0.6039215686, blue: 0.7764705882, alpha: 1)
    }

}
