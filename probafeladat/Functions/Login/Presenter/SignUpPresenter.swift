//
//  SignUpPresenter.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2020. 03. 24..
//  Copyright © 2020. WUP. All rights reserved.
//

import Foundation

protocol SignUpPresenter {
    func viewDidLoad(with viewController: SignUpView)
}

class SignUpPresenterImpl {
    
    // MARK: - Properties
    weak var view: SignUpView!
    weak var coordinator: MainCoordinator?
}

// MARK: - LoginPresenter conform
extension SignUpPresenterImpl: SignUpPresenter {
    
    func viewDidLoad(with viewController: SignUpView) {
        self.view = viewController
    }
    
}
