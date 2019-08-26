//
//  LoginViewController.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit
import IHProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    private var navigator:Navigator?
    
    var sessionViewModel = SessionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Login"
        
        self.navigator = Navigator(sender: self)
        self.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        // Navigate to gallery if a user credentials are already stored
        if SessionViewModel().userExist {
            self.navigator?.navigate(to: .gallery, mode: .push, animated: false)
        }
        // Bind UI to session actions and status
        self.bind()
    }
    
    /// TODO: better input validation and UI reaction to it. Enable loginButton only if email and password was entered
    func bind() {
        self.sessionViewModel.signingIn.bind { (signingIn) in
            signingIn ? IHProgressHUD.show() : IHProgressHUD.dismiss()
        }
    }
    
    /// Loggin action.
    @objc func login() {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            self.sessionViewModel.signIn(with: email, password: password) { (success, error) in
                if success {
                    self.loginSucceed()
                } else {
                    self.loginFail(error: error)
                }
            }
        }
    }
    
    func loginSucceed() {
        self.navigator?.navigate(to: .gallery)
    }
    
    func loginFail(error: SessionError?) {
        IHProgressHUD.showError(withStatus: error?.description)
    }
    
}
