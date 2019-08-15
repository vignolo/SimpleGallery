//
//  ImageUploader.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 14/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class ImageUploader {
    
    func uploadImage(image: UIImage, completion:((_ image: Image?) -> Void)?) {
        Storage().uploadImage(image: image, completion: { urlString in
            if let urlString = urlString {
                completion?(Image(path: urlString))
                return
            }
            completion?(nil)
        })
    }
    
}
