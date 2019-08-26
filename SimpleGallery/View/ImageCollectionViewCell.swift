//
//  ImageCollectionViewCell.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 19/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

/// Subclass UICollectionViewCell
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
        self.imageView.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.clipsToBounds = true
        self.contentView.addSubview(self.imageView)
    }
    
    func configure(viewModel: ImageViewModel) {
        let imageURL = URL(string: viewModel.thumbnail)
        // User Kingfished for image download and setting.
        self.imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.2))])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // No need for Layout Constrints. It's a simple image cell
        self.imageView.frame = self.contentView.frame
    }
}
