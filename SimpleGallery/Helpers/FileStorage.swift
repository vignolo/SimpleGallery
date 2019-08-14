//
//  Storage.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 14/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class FileStorage {
    
    enum Path: String {
        case images = "images"
    }
    enum FileType: String  {
        case image = "image/jpg"
    }
    
    func upload(data: Data, path: Path, type: FileType, completion:((_ success: Bool) -> Void)?) {
        // TODO: Add Firebase Storege upload
        
        completion?(true)
    }
    
    func uploadImage(image: UIImage, completion:((_ success: Bool) -> Void)?) {
        if let imageData = image.pngData() {
            self.upload(data: imageData, path: .images, type: .image, completion: completion)
        } else {
            completion?(false)
        }
    }
}
