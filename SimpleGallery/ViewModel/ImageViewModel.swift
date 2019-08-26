//
//  ImageViewModel.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation

struct ImageViewModel {
    private var image: Image
    var id: String {
        return self.image.id
    }
    var original: String {
        return self.image.original
    }
    var thumbnail: String {
        return self.image.thumbnail
    }
    
    enum Path: String {
        case original = "original"
        case thumbnail = "thumbnail"
    }
    
    init(_ image: Image) {
        self.image = image
    }
    
    /// Custom init from dictionary. TODO: This should be moved to Image or a decoder helper
    ///
    /// - Parameter dictionary: Dictionary
    init?(dictionary: Dictionary<String, Any>) {
        guard
            let id = dictionary.keys.first,
            let values = dictionary[id] as? [String: Any],
            let original = values[Path.original.rawValue] as? String,
            let thumbnail = values[Path.thumbnail.rawValue] as? String else { return nil }
        
        self.image = Image(id: id, original: original, thumbnail: thumbnail)
    }
}

extension ImageViewModel {
    func dictionary() -> Dictionary<String, Any> {
        return [image.id: [Path.original.rawValue : image.original, Path.thumbnail.rawValue : image.thumbnail]]
    }
}
