//
//  LoginPresenter.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2020. 03. 24..
//  Copyright © 2020. WUP. All rights reserved.
//

import Foundation

protocol LoginPresenter {
    func viewDidLoad(with viewController: LoginView)
    func loginTapped()
    func signUpTapped()
}

class LoginPresenterImpl {
    
    // MARK: - Properties
    weak var view: LoginView!
    weak var coordinator: MainCoordinator?
}

// MARK: - LoginPresenter conform
extension LoginPresenterImpl: LoginPresenter {
    
    func viewDidLoad(with viewController: LoginView) {
        self.view = viewController
    }
    
    func loginTapped() {
        
    }
    
    func signUpTapped() {
        
    }
    
}
