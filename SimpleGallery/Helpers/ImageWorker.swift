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
        let thumnail = self.resizeImage(image: image, width: ImageWorker.thumbnailSize)
        if let imageData = image.jpegData(), let thumbnailData = thumnail.jpegData()  {
            let imageID = Database().generateID()
            let imageName = "\(imageID)/\(ImageWorker.originalName)"
            let thumbnailName = "\(imageID)/\(ImageWorker.thumbnailName)"
            
            var thumbnailUrl: String? = nil
            var imageUrl: String? = nil
            
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            StorageWorker().uploadImage(imageData: imageData, name: imageName) { (imageStringUrl) in
                if let imageStringUrl = imageStringUrl {
                    imageUrl = imageStringUrl
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.enter()
            StorageWorker().uploadImage(imageData: thumbnailData, name: thumbnailName) { (thumbnailStringUrl) in
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
    
    func resizeImage(image: UIImage, width: CGFloat) -> UIImage {
        let scale = width / image.size.width
        let height = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
