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
    var fetching: Bindable<Bool> = Bindable(false)
    var uploading: Bindable<Bool> = Bindable(false)
    var deleting: Bindable<Bool> = Bindable(false)
    
    var count: Int {
        return self.images.value.count
    }
    
    func image(at index:Int) -> ImageViewModel {
        return self.images.value[index]
    }
    
    func fetch() {
        self.fetching.value = true
        DatabaseWorker().fetchImages { (images) in
            self.images.value = images
            self.fetching.value = false
        }
    }
    
    func upload(image: UIImage, completion: ((_ error: FileError?) -> Void)?) {
        self.uploading.value = true
        ImageWorker().uploadAndSave(image: image) { image, error in
            self.uploading.value = false
            completion?(error)
            if error == nil { self.fetch() }
        }
    }
    
    func delete(image: ImageViewModel, completion: ((_ error: FileError?) -> Void)?) {
        self.deleting.value = true
        ImageWorker().deleteImage(with: image.id) { error in
            self.deleting.value = false
            completion?(error)
            if error == nil { self.fetch() }
        }
    }
}
