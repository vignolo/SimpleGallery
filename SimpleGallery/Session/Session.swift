//
//  Session.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 13/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

class Session {
    
    var user: User? {
        // TODO: check for stored session. Returning nil for now.
        return nil
    }
    var valid: Bool {
        return user != nil ? true : false
    }
    
    func delete() {
        // TODO: Remove stored session
    }
    
    func authenticate(with email: String, password: String, completion: ((_ sucess: Bool) -> Void)) {
        // TODO: Firebase Auth
        if email == "vignolo@gmail.com" && password == "1234" {
            // TODO: Store user credentials
            completion(true)
        } else {
            completion(false)
        }
    }
}
