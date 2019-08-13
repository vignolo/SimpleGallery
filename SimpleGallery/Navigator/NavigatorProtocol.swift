//
//  NavigatorProtocol.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

protocol NavigatorProtocol {
    associatedtype Destination
    associatedtype Mode
    
    func navigate(to destination: Destination, mode: Mode, sender: UIViewController)
}
