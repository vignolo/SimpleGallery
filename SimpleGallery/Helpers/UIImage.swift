//
//  UIImage.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 15/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import UIKit

extension UIImage {
    static let defaultJpegQuality: CGFloat = 0.5
    
    func jpegData() -> Data? {
        return self.jpegData(compressionQuality: UIImage.defaultJpegQuality)
    }
}
