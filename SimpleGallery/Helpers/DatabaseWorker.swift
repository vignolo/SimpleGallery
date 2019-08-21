//
//  DatabaseWorker.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 19/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

class DatabaseWorker {
    
    func saveImage(image: ImageViewModel, completion: ((_ error: Error?) -> Void)?) {
        
        let imageDictionary = image.dictionary()
        Database().save(data: imageDictionary, id: image.id, path: .images) { (error) in
            completion?(error)
        }
    }
    
    func fetchImages(completion: (([ImageViewModel])-> Void)?) {
        Database().fetch(path: .images) { (images) in
            let array = images?.compactMap({ ImageViewModel(dictionary: $0) }) ?? []
            completion?(array)
        }
    }
    
    func deleteImage(with id: String, completion: ((_ error: Error?) -> Void)?) {
        Database().delete(with: id, path: .images, completion: completion)
    }
    
}
