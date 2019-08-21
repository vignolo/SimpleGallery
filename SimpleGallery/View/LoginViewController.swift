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
        
        if SessionViewModel().userExist {
            self.navigator?.navigate(to: .gallery, mode: .push, animated: false)
        }
        
        self.bind()
    }
    
    func bind() {
        self.sessionViewModel.signingIn.bind { (signingIn) in
            signingIn ? IHProgressHUD.show() : IHProgressHUD.dismiss()
        }
    }
    
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
    
    func loginFail(error: Error?) {
        let errorMessage = error?.localizedDescription
        IHProgressHUD.showError(withStatus: errorMessage)
    }
    
}
