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
    
    var navigationController: UINavigationController?
    
    enum Destination {
        case login
        case gallery
        case imageDetail(image: Image)
        case imagePicker
        case custom(viewController: UIViewController)
    }
    
    enum Mode {
        case push
        case present
    }
    
    init(sender: UIViewController) {
        self.navigationController = sender.navigationController
    }
    
    func navigate(to destination: Destination, mode:Mode = .push, animated:Bool = true) {
        
        let viewController = self.viewController(for: destination)
        
        switch mode {
            case .present:
                self.navigationController?.present(viewController, animated: animated, completion: nil)
            case .push:
                self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    func navigateToRoot(animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    private func viewController(for destination: Destination) -> UIViewController {
        
        switch destination {
            case .login:
                return LoginViewController()
            case .gallery:
                return GalleryViewController()
            case .imageDetail(let image):
                return ImageDetailViewController(image: image)
            case .imagePicker:
                return ImagePickerViewController()
            case .custom(let viewController):
                return viewController
        }
    }
}
