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
    /// Current stored UserViewModel or nil if there is none
    private var user: UserViewModel? {
        return UserViewModel(user: session.user)
    }
    /// Bool verification if a current user exist stored
    var userExist: Bool {
        return user != nil
    }
    /// Signing in property. true if a sing in operation is currently active
    var signingIn: Bindable<Bool> = Bindable(false)
    
    /// Check is the current stored user credentials are valid
    ///
    /// - Parameter completion: block invoqued at the end of the proccess. Return true if valid, false if not
    func isValidSession(completion: @escaping (_ valid: Bool) -> Void) {
        self.session.isValidSession(completion: completion)
    }
    
    /// Sign in a user and store the user if credentials are valid
    ///
    /// - Parameters:
    ///   - email: user email
    ///   - password: user password
    ///   - completion: block invoqued at the end of the proccess. Return success:Bool true if credentials are valid or false if not with error:SessionError
    func signIn(with email: String, password: String, completion: @escaping ((_ sucess: Bool, _ error: SessionError?) -> Void)) {
        self.signingIn.value = true
        self.session.signIn(with: email, password: password) { (success, error) in
            self.signingIn.value = false
            completion(success, error)
        }
    }
    
    /// Sing out the user and delete stored credentials
    func signOut() {
        self.session.signOut()
    }
    
}
