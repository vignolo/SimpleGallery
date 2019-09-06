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
    
    /// Navigator destinations
    ///
    /// - signIn: sign in view
    /// - gallery: gallery view
    /// - imageDetail: image details view
    /// - imagePicker: image picker
    /// - custom: use this option to push a custom view controller
    enum Destination {
        case signIn
        case signUp
        case gallery
        case imageDetail(image: ImageViewModel)
        case imagePicker
        case custom(viewController: UIViewController)
    }
    
    /// Navigation mode
    ///
    /// - push: push the view controller to the navigationController stack
    /// - present: present the view controller based on the current modalTransitionStyle. normaly .coverVertical
    enum Mode {
        case push
        case present
    }
    
    init(sender: UIViewController) {
        self.navigationController = sender.navigationController
    }
    
    /// Navigate to a Destination
    ///
    /// - Parameters:
    ///   - destination: the destination were to navigato
    ///   - mode: navigation mode
    ///   - animated: bool telling if navigation shoud be animated. Default is true
    func navigate(to destination: Destination, mode:Mode = .push, animated:Bool = true) {
        
        let viewController = self.viewController(for: destination)
        
        switch mode {
            case .present:
                self.navigationController?.present(viewController, animated: animated, completion: nil)
            case .push:
                self.navigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    /// Navigate to root view in the navigationController
    ///
    /// - Parameter animated: bool telling if navigation shoud be animated. Default is true
    func navigateToRoot(animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    /// Instanciate and return view controller depending on the Destination
    ///
    /// - destination: the destination
    /// - Returns: returns a instanciated view controller
    private func viewController(for destination: Destination) -> UIViewController {
        
        switch destination {
            case .signIn:
                return SignInViewController()
            case .signUp:
                return SignUpViewController()
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
