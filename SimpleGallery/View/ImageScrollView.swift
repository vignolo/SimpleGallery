//
//  ImageScrollView.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 02/09/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import IHProgressHUD

class ImageScrollView: UIScrollView {
    
    var imageView = UIImageView()
    private var imageViewBottomConstraint = NSLayoutConstraint()
    private var imageViewLeadingConstraint = NSLayoutConstraint()
    private var imageViewTopConstraint = NSLayoutConstraint()
    private var imageViewTrailingConstraint = NSLayoutConstraint()
    
    init(url: URL) {
        super.init(frame: CGRect.zero)
        self.configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        // ImageView
        self.addSubview(self.imageView)
        self.imageView.alpha = 0
        self.imageView.clipsToBounds = true
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints
        self.imageViewLeadingConstraint = imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        self.imageViewTrailingConstraint = imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        self.imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: topAnchor)
        self.imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([imageViewLeadingConstraint, imageViewTrailingConstraint, imageViewTopConstraint, imageViewBottomConstraint])
        
        // ScrollView
        self.contentInsetAdjustmentBehavior = .never
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.alwaysBounceHorizontal = true
        self.alwaysBounceVertical = true
        self.delegate = self
        
    }
    
    func setImage(from url: URL) {
        self.imageView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil) { result in
            switch result {
            case .success(_):
                self.showImage()
            case .failure(let error):
                IHProgressHUD.showError(withStatus: error.localizedDescription)
            }
        }
    }
    
    func showImage() {
        self.setZoomScale()
        self.centerImage()
        
        UIView.animate(withDuration: 0.2) {
            self.imageView.alpha = 1.0
        }
    }
    
    func setZoomScale() {
        self.imageView.sizeToFit()
        let size = self.imageView.image?.size ?? self.imageView.frame.size
        let widthScale = self.frame.size.width / size.width
        let heightScale = self.frame.size.height / size.height
        let minScale = min(widthScale, heightScale)
        self.minimumZoomScale = minScale
        self.zoomScale = minScale
    }
    
    func centerImage() {
        let yOffset = max(0, (bounds.size.height - self.imageView.frame.height) / 2)
        self.imageViewTopConstraint.constant = yOffset
        self.imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (bounds.size.width - self.imageView.frame.width) / 2)
        self.imageViewLeadingConstraint.constant = xOffset
        self.imageViewTrailingConstraint.constant = xOffset
        
        self.layoutIfNeeded()
    }
    
}

extension ImageScrollView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.centerImage()
    }
    
}
