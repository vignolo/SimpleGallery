//
//  FileError.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 21/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

/// Custom Error for files operations
///
/// - uploading: Return this if a upload to storage operation fails
/// - saving: Return this id saving to database operation fails
/// - deleting: Return this is deleting file from database fails
/// - custom: Return this for custom error message description
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
        }
    }
}
