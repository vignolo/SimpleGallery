//
//  ImagesViewModel.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 13/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class ImagesViewModel {
    
    var images: Bindable<[ImageViewModel]> = Bindable([])
    /// Fetching property. true if a fetch operation is currently active
    var fetching: Bindable<Bool> = Bindable(false)
    /// Uploading property. true if a upload operation is currently active
    var uploading: Bindable<Bool> = Bindable(false)
    /// Deleting property. true if a dele operation is currently active
    var deleting: Bindable<Bool> = Bindable(false)
    
    /// Number of images
    var count: Int {
        return self.images.value.count
    }
    
    /// Return the ImageViewModel at a specific index
    ///
    /// - Parameter index: index for Image
    /// - Returns: ImageViewModel
    func image(at index:Int) -> ImageViewModel {
        return self.images.value[index]
    }
    
    /// Start a fetching operation
    func fetch() {
        self.fetching.value = true
        DatabaseWorker().fetchImages { (images) in
            self.images.value = images
            self.fetching.value = false
        }
    }
    
    /// Upload a image
    ///
    /// - Parameters:
    ///   - image: UIImage to upload
    ///   - completion: block invoqued at the end of the proccess. Return error:FileError if operation fails
    func upload(image: UIImage, completion: ((_ error: FileError?) -> Void)?) {
        self.uploading.value = true
        ImageWorker().uploadAndSave(image: image) { image, error in
            self.uploading.value = false
            completion?(error)
            if error == nil { self.fetch() }
        }
    }
    
    /// Delete a image
    ///
    /// - Parameters:
    ///   - image: ImageVIewModel to delete
    ///   - completion: block invoqued at the end of the proccess. Return error:FileError if operation fails
    func delete(image: ImageViewModel, completion: ((_ error: FileError?) -> Void)?) {
        self.deleting.value = true
        ImageWorker().deleteImage(with: image.id) { error in
            self.deleting.value = false
            completion?(error)
            if error == nil { self.fetch() }
        }
    }
}
