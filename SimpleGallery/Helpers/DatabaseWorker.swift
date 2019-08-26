//
//  DatabaseWorker.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 19/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

class DatabaseWorker {
    
    /// Save a image to database
    ///
    /// - Parameters:
    ///   - image: ImageViewModel to be saved
    ///   - completion: block invoqued at the end of the proccess. Return error: Error if operatiomn fails
    func saveImage(image: ImageViewModel, completion: ((_ error: Error?) -> Void)?) {
        let imageDictionary = image.dictionary()
        Database().save(data: imageDictionary, id: image.id, path: .images) { (error) in
            completion?(error)
        }
    }
    
    /// Fetch saved images
    ///
    /// - Parameter completion: block invoqued at the end of the proccess. Return a Array of ImageViewModel
    func fetchImages(completion: (([ImageViewModel])-> Void)?) {
        Database().fetch(path: .images) { (images) in
            let array = images?.compactMap({ ImageViewModel(dictionary: $0) }) ?? []
            completion?(array)
        }
    }
    
    /// Delete a Image from Database
    ///
    /// - Parameters:
    ///   - id: String image identifier
    ///   - completion: block invoqued at the end of the proccess. Return error:Error if operation fails
    func deleteImage(with id: String, completion: ((_ error: Error?) -> Void)?) {
        Database().delete(with: id, path: .images, completion: completion)
    }
    
}
