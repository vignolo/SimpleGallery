//
//  Storage.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 14/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import FirebaseStorage
import UIKit

typealias FIRStorage = FirebaseStorage.Storage

class Storage {
    
    
    // Default storage paths
    enum Path: String {
        case images = "images"
    }
    // Default starage file types
    enum FileType: String  {
        case image = "image/jpeg"
    }
    
    /// Upload a file to storage
    ///
    /// - Parameters:
    ///   - data: file Data
    ///   - path: default path to storage
    ///   - name: file name
    ///   - type: file type
    ///   - completion: block invoqued at the end of the proccess. Return full file path string or nil if fail
    func upload(data: Data, path: Path, name:String, type: FileType, completion:((_ urlString: String?) -> Void)?) {
        let fileRef = FIRStorage.storage().reference().child(path.rawValue).child(name)
        let metadata = StorageMetadata()
        metadata.contentType = type.rawValue
        
        fileRef.putData(data, metadata: metadata) { (metadata, error) in
            if metadata != nil {
                fileRef.downloadURL { (url, error) in
                    completion?(url?.absoluteString)
                }
            } else {
                completion?(nil)
            }
        }
    }
    
    /// Delete a file from Storage
    ///
    /// - Parameters:
    ///   - name: file name
    ///   - path: default path where is located
    ///   - completion: block invoqued at the end of the proccess. Return error:FileError or nil if succeed
    func delete(with name: String, path: Path, completion: ((_ error:FileError?) -> Void)?) {
        let fileRef = FIRStorage.storage().reference().child(path.rawValue).child(name)
        fileRef.delete { (error) in
            (error != nil) ? completion?(FileError.custom(description: error!.localizedDescription)) : completion?(nil)
        }
    }

    
}
