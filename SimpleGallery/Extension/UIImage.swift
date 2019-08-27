//
//  UIImage.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 15/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Default image quality for thumbnails
    static let defaultJpegQuality: CGFloat = 0.5
    
    func jpegData() -> Data? {
        return self.jpegData(compressionQuality: UIImage.defaultJpegQuality)
    }
    
    /// Resize a image to a specific width maintaining aspect ratio.
    ///
    /// - Parameter width: New image width
    /// - Returns: UIImage
    func resize(width: CGFloat) -> UIImage {
        let scale = width / self.size.width
        let height = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
