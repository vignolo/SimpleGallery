//
//  ImagePickerViewController.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

/// Subclass UIImagePickerController
class ImagePickerViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// block invoqued at the end of the picking proccess. Return image:UIImage or nil if user cancel
    var completion: ((UIImage?) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.allowsEditing = false
        self.sourceType = .photoLibrary
        self.navigationBar.tintColor = UIColor(templateColor: .pink)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(image: image)
    }
    
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(image: nil)
    }
    
    func dismiss(image:UIImage?) {
        self.dismiss(animated: true, completion: { [weak self] in
            self?.completion?(image)
        })
    }
    
}
