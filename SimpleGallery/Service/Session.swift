//
//  Session.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 13/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias FIRUser = FirebaseAuth.User

class Session {
    
    var user: User? {
        return self.cast(firebase: Auth.auth().currentUser)
    }
    
    func isValidSession(completion: @escaping (_ valid: Bool) -> Void) {
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }
        
        // Forcing token refres to verify user was not disabled or deleted
        user.getIDTokenForcingRefresh(true) { (token, error) in
            completion(error == nil)
        }
    }
    
    
    /// Remove current session stored credentials
    func signOut() {
        try! Auth.auth().signOut()
    }
    
    
    /// Validate email, password and store session credentials
    ///
    /// - Parameters:
    ///   - email: user email
    ///   - password: user password
    ///   - completion: block invoqued at the end of the proccess. Returnig success:Bool and error:SessionError
    func signIn(with email: String, password: String, completion: @escaping ((_ sucess: Bool, _ error: SessionError?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            guard error == nil else {
                // Return SessionError.custom for debug porpuses. This should be changed to .wrongCredentials
                completion(false, SessionError.custom(description: error!.localizedDescription))
                return
            }
            completion(true, nil)
        }
    }
}

extension Session {
    
    /// Cast a Firebase User to User model
    ///
    /// - Parameter user: Firebase User object
    /// - Returns: User object or nil if invalid
    private func cast(firebase user:FIRUser?) -> User? {
        if let user =  user {
            return User(id: user.uid, email: user.email)
        } else {
            return nil
        }
    }
}
