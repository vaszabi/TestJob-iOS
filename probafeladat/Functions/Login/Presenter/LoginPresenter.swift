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
    func navigateToSignUp()
}

class LoginPresenterImpl {
    
    // MARK: - Properties
    private weak var view: LoginView?
    weak var coordinator: MainCoordinator?
    
    
    init(view: LoginViewController) {
        self.view = view
    }
}



// MARK: - LoginPresenter conform
extension LoginPresenterImpl: LoginPresenter {
    
    func viewDidLoad(with viewController: LoginView) {
        self.view = viewController
    }
    
    func loginTapped() {
        
    }
    
    func navigateToSignUp() {
        print("KURVA ANYÁD")
        coordinator?.navigateToSignUp()
    }
    
}
