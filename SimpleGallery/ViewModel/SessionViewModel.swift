//
//  SessionViewModel.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 15/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

//protocol SessionViewModelProtocol {
//    <#requirements#>
//}

class SessionViewModel {
    
    private var session = Session()
    private var user: UserViewModel? {
        return UserViewModel(user: session.user)
    }
    var userExist: Bool {
        return user != nil
    }
    
    func isValidSession(completion: @escaping (_ valid: Bool) -> Void) {
        session.isValidSession(completion: completion)
    }
    
    func signIn(with email: String, password: String, completion: @escaping ((_ sucess: Bool, _ error: Error?) -> Void)) {
        self.session.signIn(with: email, password: password, completion: completion)
    }
    
    func signOut() {
        self.session.signOut()
    }
    
}
