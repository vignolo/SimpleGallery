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
    
    enum Path: String {
        case images = "images"
    }
    enum FileType: String  {
        case image = "image/jpeg"
    }
    
    func delete(with id: String, path: Path, completion: ((_ error:FileError?) -> Void)?) {
        let fileRef = FIRStorage.storage().reference().child(path.rawValue).child(id)
        fileRef.delete { (error) in
            (error != nil) ? completion?(FileError.custom(description: error!.localizedDescription)) : completion?(nil)
        }
    }
    
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
    
}
