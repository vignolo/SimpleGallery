//
//  ImageCollectionViewCell.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 19/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionViewCell"
    
    var imageView = UIImageView()
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    func configureView() {
        self.imageView.backgroundColor = .gray
        self.addSubview(self.imageView)
    }
    
    func configure(viewModel: ImageViewModel) {
        // Download Image
    }
    
    override func layoutSubviews() {
        self.imageView.frame = self.frame
    }
}
