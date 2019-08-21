//
//  FileError.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 21/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

enum FileError: Error {
    
    case uploading
    case saving
    case deleting
    case custom(description: String)
    
    var description: String? {
        switch self {
        case .uploading:
            return "Error uploading to storage"
        case .saving:
            return "Error saving file information"
        case .deleting:
            return "Error deleting file"
        case .custom(let description):
            return description
        default:
            return self.localizedDescription
        }
    }
}
