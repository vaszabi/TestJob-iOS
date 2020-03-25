//
//  LoginTextField.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2020. 03. 24..
//  Copyright © 2020. WUP. All rights reserved.
//

import UIKit

class LoginTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTextField()
    }
    
    private func setupTextField(){
        self.borderStyle = .none
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        self.textColor = UIColor(white: 0.9, alpha: 0.8)
        self.font = UIFont.systemFont(ofSize: 17)
        self.autocorrectionType = .no
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7)]))
        self.attributedPlaceholder = placeholder
        self.setLeftPaddingPoints(20)
    }

}
