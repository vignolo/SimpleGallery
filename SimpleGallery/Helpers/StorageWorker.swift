//
//  StorageWorker.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 15/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class StorageWorker {
    
    var storage = Storage()
    
    /// Upload a new UIImage to Storage
    ///
    /// - Parameters:
    ///   - imageData: Data of the image to upload
    ///   - name: String name to be used to reference the new image
    ///   - completion: block invoqued at the end of the proccess. Return the full http path to image or nil if operation fails
    func uploadImage(imageData: Data, name: String, completion:((_ urlString: String?) -> Void)?) {
        self.storage.upload(data: imageData, path: .images, name: name, type: .image, completion: completion)
    }
    
    /// Delete a Image from
    ///
    /// - Parameters:
    ///   - name: String name of the image. Should include path.
    ///   - completion: block invoqued at the end of the proccess. Return error:FileError if operation fails
    func deleteImage(with name: String, completion: ((_ error: FileError?) -> Void)?) {
        self.storage.delete(with: name, path: .images, completion: completion)
    }
}
