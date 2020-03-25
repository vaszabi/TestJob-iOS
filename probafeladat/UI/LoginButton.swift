//
//  LoginButton.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2020. 03. 25..
//  Copyright © 2020. WUP. All rights reserved.
//

import UIKit

class LoginButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    
    private func setupButton() {
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
    }

}
