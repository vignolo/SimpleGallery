//
//  Navigator.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class Navigator: NavigatorProtocol {
    
    enum Destination {
        case login
        case imageDetail(image: Image)
        case imagePicker
    }
    
    enum Mode {
        case push
        case present
    }
    
    func navigate(to destination: Destination, mode:Mode = .push, sender: UIViewController) {
        
        let viewController = self.viewController(for: destination)
        
        switch mode {
            case .present:
                sender.navigationController?.present(viewController, animated: true, completion: nil)
            case .push:
                sender.navigationController?.pushViewController(viewController, animated: true)
        }
        
    }
    
    private func viewController(for destination: Destination) -> UIViewController {
        
        switch destination {
            case .login:
                return LoginViewController()
            case .imageDetail(let image):
                return ImageDetailViewController(image: image)
            case .imagePicker:
                return ImagePickerViewController()
        }
    }
}
