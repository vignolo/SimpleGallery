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
    
    func signOut() {
        try! Auth.auth().signOut()
    }
    
    func signIn(with email: String, password: String, completion: @escaping ((_ sucess: Bool, _ error: Error?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            completion(result != nil, error)
        }
    }
}

extension Session {
    private func cast(firebase user:FIRUser?) -> User? {
        if let user =  user {
            return User(id: user.uid, email: user.email)
        } else {
            return nil
        }
    }
}
