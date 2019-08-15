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
    
    func upload(data: Data, path: Path, type: FileType, completion:((_ urlString: String?) -> Void)?) {
        let fileRef = FIRStorage.storage().reference().child(Path.images.rawValue).child("image.jpg")
        let metadata = StorageMetadata()
        metadata.contentType = FileType.image.rawValue
        
        fileRef.putData(data, metadata: metadata) { (metadata, error) in
            if metadata != nil {
                fileRef.downloadURL { (url, error) in
                    completion?(url?.absoluteString)
                }
            } else {
                print("Upload Error")
                completion?(nil)
            }
        }
    }
    
    func uploadImage(image: UIImage, completion:((_ urlString: String?) -> Void)?) {
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            self.upload(data: imageData, path: .images, type: .image, completion: completion)
        } else {
            completion?(nil)
        }
    }
}
