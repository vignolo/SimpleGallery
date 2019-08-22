//
//  SessionViewModel.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 15/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

class SessionViewModel {
    
    private var session = Session()
    private var user: UserViewModel? {
        return UserViewModel(user: session.user)
    }
    var userExist: Bool {
        return user != nil
    }
    var signingIn: Bindable<Bool> = Bindable(false)
    
    func isValidSession(completion: @escaping (_ valid: Bool) -> Void) {
        self.session.isValidSession(completion: completion)
    }
    
    func signIn(with email: String, password: String, completion: @escaping ((_ sucess: Bool, _ error: SessionError?) -> Void)) {
        self.signingIn.value = true
        self.session.signIn(with: email, password: password) { (success, error) in
            self.signingIn.value = false
            completion(success, error)
        }
    }
    
    func signOut() {
        self.session.signOut()
    }
    
}
