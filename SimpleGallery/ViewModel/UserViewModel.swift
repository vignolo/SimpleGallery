//
//  UserViewModel.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 13/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

struct UserViewModel {
    var user: User
    
    init?(user: User?) {
        guard let user = user else {
            return nil
        }
        
        self.user = user
    }
}
