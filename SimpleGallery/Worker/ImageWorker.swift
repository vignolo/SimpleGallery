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
    
    // Default thumbnail size
    static let thumbnailSize: CGFloat = 200
    
    
    /// Upload a image to Storage and save image reference path to Database
    ///
    /// - Parameters:
    ///   - image: UIImage to upload
    ///   - completion: block invoqued at the end of the proccess. Returns image:ImageViewModel, error:FileError
    func uploadAndSave(image: UIImage, completion:((_ image: ImageViewModel?, _ error: FileError?) -> Void)?) {
        self.uploadImage(image: image) { (image) in
            guard let image = image else {
                completion?(nil, FileError.uploading)
                return
            }
            
            let imageViewModel = ImageViewModel(image)
            DatabaseWorker().saveImage(image: imageViewModel, completion: { (error) in
                guard error == nil else {
                    completion?(nil, FileError.saving)
                    return
                }
                let imageViewModel = ImageViewModel(image)
                completion?(imageViewModel, nil)
            })
        }
    }
    
    
    /// Upload a image and a generated thumbnail to Storage
    ///
    /// - Parameters:
    ///   - image: UIimage to upload
    ///   - completion: block invoqued at the end of the proccess. Returns image:Image or nil if there is and error
    private func uploadImage(image: UIImage, completion:((_ image: Image?) -> Void)?) {
        
        // Create thumbnail UIImage
        let thumnail = image.resize(width: ImageWorker.thumbnailSize)
        
        if let imageData = image.jpegData(), let thumbnailData = thumnail.jpegData()  {
            // Get a database auto-generated ID
            let imageID = Database().generateID()
            
            let imageName = self.imagePath(with: imageID, path: .original)
            let thumbnailName = self.imagePath(with: imageID, path: .thumbnail)
            
            var imageUrl: String? = nil
            var thumbnailUrl: String? = nil
            
            let storageWorker = StorageWorker()
            // Using DispatchGroup to syncronize image upload
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
                // Finaly return Image object if original and thumbnail succeed to upload
                completion?(Image(id: imageID, original: imageUrl, thumbnail: thumbnailUrl))
            }
            
        }
    }
    
    
    /// Delete a image (original and thumbnail) from Storage
    ///
    /// - Parameters:
    ///   - id: image identifier
    ///   - completion: block invoqued at the end of the proccess. Return error:FileError or nil if succeed
    func deleteImage(with id: String, completion: ((_ error: FileError?) -> Void)?) {
        // First delete file reference from Database
        DatabaseWorker().deleteImage(with: id) { (error) in
            guard error == nil else {
                completion?(FileError.deleting)
                return
            }
            // Delete files from Storage without showing error to user. This is because reference was already deleted and the user does not need to know for internal errors.
            let storageWorker = StorageWorker()
            storageWorker.deleteImage(with: self.imagePath(with: id, path: .thumbnail), completion: nil)
            storageWorker.deleteImage(with: self.imagePath(with: id, path: .original), completion: nil)
            completion?(nil)
        }
    }

}

private extension ImageWorker {
    // Construct and return full image path
    func imagePath(with id: String, path: ImageViewModel.Path ) -> String {
        return "\(id)/\(path.rawValue).jpg"
    }
}
