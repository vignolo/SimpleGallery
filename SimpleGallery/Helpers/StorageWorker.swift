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
    
    func uploadImage(imageData: Data, name: String, completion:((_ urlString: String?) -> Void)?) {
        self.storage.upload(data: imageData, path: .images, name: name, type: .image, completion: completion)
    }
    
    func deleteImage(with name: String, completion: ((_ error: FileError?) -> Void)?) {
        self.storage.delete(with: name, path: .images, completion: completion)
    }
}
