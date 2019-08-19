//
//  ImageWorker.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 14/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class ImageWorker {
    
    static let thumbnailSize: CGFloat = 200
    static let thumbnailName: String = "thumbnail.jpg"
    static let originalName: String = "original"
    
    func uploadImage(image: UIImage, completion:((_ image: Image?) -> Void)?) {
        let thumnail = image.resize(width: ImageWorker.thumbnailSize)
        if let imageData = image.jpegData(), let thumbnailData = thumnail.jpegData()  {
            let imageID = Database().generateID()
            
            let imageName = "\(imageID)/\(ImageWorker.originalName)"
            let thumbnailName = "\(imageID)/\(ImageWorker.thumbnailName)"
            
            var imageUrl: String? = nil
            var thumbnailUrl: String? = nil
            
            let storageWorker = StorageWorker()
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            storageWorker.uploadImage(imageData: imageData, name: imageName) { (imageStringUrl) in
                if let imageStringUrl = imageStringUrl {
                    imageUrl = imageStringUrl
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            storageWorker.uploadImage(imageData: thumbnailData, name: thumbnailName) { (thumbnailStringUrl) in
                if let thumbnailStringUrl = thumbnailStringUrl {
                    thumbnailUrl = thumbnailStringUrl
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: DispatchQueue.main) {
                guard let imageUrl = imageUrl, let thumbnailUrl = thumbnailUrl else {
                    completion?(nil)
                    return
                }
                
                completion?(Image(id: imageID, original: imageUrl, thumbnail: thumbnailUrl))
            }
            
        }
    }
}
