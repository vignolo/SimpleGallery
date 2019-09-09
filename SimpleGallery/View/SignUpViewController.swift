//
//  SignUpViewController.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 05/09/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit
import IHProgressHUD

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: SolidButton!
    private var navigator:Navigator?
    
    var sessionViewModel = SessionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        
        self.navigator = Navigator(sender: self)
        self.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        self.bind()
    }
    
    func bind() {
        self.sessionViewModel.signingUp.bind { (signingUp) in
             signingUp ? IHProgressHUD.show() : IHProgressHUD.dismiss()
        }
    }
    
    /// Sing up action
    @objc func signUp() {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            self.sessionViewModel.signUp(with: email, password: password) { (success, error) in
                if success {
                    self.signUpSucceed()
                } else {
                    self.signUpFail(error: error)
                }
            }
        }
    }
    
    func signUpSucceed() {
        self.navigator?.navigate(to: .gallery)
    }
    
    func signUpFail(error: SessionError?) {
        IHProgressHUD.showError(withStatus: error?.description)
    }
}
