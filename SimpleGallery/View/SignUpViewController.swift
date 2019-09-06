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
        
        self.navigator = Navigator(sender: self)
        self.signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        
        
    }
    
    @objc func signUp() {
        
    }
}
