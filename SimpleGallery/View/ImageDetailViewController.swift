//
//  ImageDetailViewController.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

/// Not impplemented yet.
class ImageDetailViewController: UIViewController {
    private var imageViewModel: ImageViewModel
    var scrollView: ImageScrollView!
    
    init(image: ImageViewModel) {
        self.imageViewModel = image
        let imageURL = URL(string: self.imageViewModel.original)
        self.scrollView = ImageScrollView(url: imageURL!)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        if let url = URL(string: self.imageViewModel.original) {
            self.scrollView.setImage(from: url)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.setZoomScale()
    }
}
