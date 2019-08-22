//
//  SessionError.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 22/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

enum SessionError: Error {
    
    case wrongCredentials
    case expired
    case custom(description: String)
    
    var description: String? {
        switch self {
        case .wrongCredentials:
            return "Wrong username or password"
        case .expired:
            return "Sessionas expired"
        case .custom(let description):
            return description
        }
    }
}
