//
//  ImagesViewModel.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 13/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

class ImagesViewModel {
    
    var images: Bindable<[ImageViewModel]> = Bindable([])
    var fetching: Bindable<Bool> = Bindable(false)
    
    var count: Int {
        return self.images.value.count
    }
    
    func fetch() {
        //
    }
}
