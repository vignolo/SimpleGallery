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
        Database().save(data: imageDictionary, path: .images) { (error) in
            completion?(error)
        }
    }
    
    func fetchImages(completion: (([ImageViewModel])-> Void)?) {
        Database().fetch(path: .images) { (images) in
            let array = images?.compactMap({ ImageViewModel(dictionary: $0) }) ?? []
            completion?(array)
        }
    }
    
}
