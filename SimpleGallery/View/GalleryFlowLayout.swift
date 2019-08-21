//
//  GalleryFlowLayout.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 20/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class GalleryFlowLayout: UICollectionViewFlowLayout {
    
    private var spacing: CGFloat = 3
    private var items: CGFloat = 3
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }

        let collectionViewWidth = collectionView.bounds.size.width
        let cellWidth = ((collectionViewWidth - spacing * (items + 1)) / items).rounded(.down)
        self.itemSize = CGSize(width: cellWidth, height: cellWidth)
        self.minimumLineSpacing = spacing
        self.minimumInteritemSpacing = 0
        self.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        self.sectionInsetReference = .fromSafeArea
    }
}
