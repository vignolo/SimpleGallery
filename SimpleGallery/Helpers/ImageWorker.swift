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
    
    func uploadAndSave(image: UIImage, completion:((_ image: ImageViewModel?) -> Void)?) {
        self.uploadImage(image: image) { (image) in
            guard let image = image else {
                completion?(nil)
                return
            }
            
            let imageViewModel = ImageViewModel(image)
            
            DatabaseWorker().saveImage(image: imageViewModel, completion: { (error) in
                guard error == nil else {
                    //print("Error saving: \(error!.localizedDescription)")
                    completion?(nil)
                    return
                }
                completion?(imageViewModel)
            })
        }
    }
    
    private func uploadImage(image: UIImage, completion:((_ image: Image?) -> Void)?) {
        let thumnail = image.resize(width: ImageWorker.thumbnailSize)
        if let imageData = image.jpegData(), let thumbnailData = thumnail.jpegData()  {
            let imageID = Database().generateID()
            
            let imageName = self.imagePath(with: imageID, path: .original)
            let thumbnailName = self.imagePath(with: imageID, path: .thumbnail)
            
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

private extension ImageWorker {
    func imagePath(with id: String, path: ImageViewModel.Path ) -> String {
        return "\(id)/\(path.rawValue).jpg"
    }
}
