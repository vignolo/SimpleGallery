//
//  LoginViewController.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var session = Session()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc func login() {
        if let email = self.emailTextField.text, let password = self.passwordTextField.text {
            session.authenticate(with: email, password: password) { (success, error) in
                if success {
                    self.loginSucceed()
                } else {
                    self.loginFail(error: error)
                }
            }
        }
    }
    
    func loginSucceed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loginFail(error: Error?) {
        // TODO: Show Alert
        let errorMessage = error.debugDescription 
        print("Error: \(errorMessage)")
    }
    
}
