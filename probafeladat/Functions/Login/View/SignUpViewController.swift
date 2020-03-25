//
//  SignUpViewController.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2020. 03. 24..
//  Copyright © 2020. WUP. All rights reserved.
//

import UIKit

protocol SignUpView: AnyObject {
    func showError()
    func registerTapped()
}

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    weak var presenter: SignUpPresenterImpl!
    
    // MARK: - Outlets
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeViews()
        presenter?.viewDidLoad(with: self)
    }
    
    private func customizeViews() {
        
    }
    
}

// MARK: - SignUpView conform
extension SignUpViewController: SignUpView {
    
    func showError() {
        
    }
    
    func registerTapped() {
        
    }
    
}
