//
//  LoginViewController.swift
//  probafeladat
//
//  Created by Szabolcs Varga on 2020. 03. 24..
//  Copyright © 2020. WUP. All rights reserved.
//

import UIKit

protocol LoginView: AnyObject {
    func showWrongCredentials()
    func signupTapped()
}

class LoginViewController: UIViewController, Storyboarded {
    
    // MARK: - Properties
    weak var presenter: LoginPresenterImpl!
    
    // MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var usernameTextField: LoginTextField!
    @IBOutlet weak var passwordTextField: LoginTextField!
    @IBOutlet weak var loginBtn: LoginButton!
    @IBOutlet weak var signUpBtn: LoginButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeViews()
        presenter?.viewDidLoad(with: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private functions
    private func customizeViews() {
        self.tabBarController?.tabBar.isHidden = true
        backgroundImageView.addBlurToView()
        passwordTextField.placeholder = "Password"
        
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        loginBtn.layer.borderColor = UIColor.greenBorderColor.cgColor
        signUpBtn.setAttributedTitle(attributedString, for: .normal)
        signUpBtn.layer.borderColor = UIColor.redBorderColor.cgColor
    }
    
}

extension LoginViewController: LoginView {
    func showWrongCredentials() {
        
    }
    
    func signupTapped() {
        
    }
    
}

