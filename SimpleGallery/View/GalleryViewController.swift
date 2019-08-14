//
//  GalleryViewController.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {
    
    private let navigator = Navigator()
    var session = Session()
    var imagesViewModel = ImagesViewModel()
    var collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewLayout())
    var activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.bind()
    }
    
    func bind() {
        self.imagesViewModel.images.bind { (_) in
            self.collectionView.reloadData()
        }
        self.imagesViewModel.fetching.bind { (fetching) in
            self.activityIndicatorView.isHidden = !fetching
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.session.valid {
            self.imagesViewModel.fetch()
        } else {
            self.navigator.navigate(to: .login, mode: .present, sender: self)
        }
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        return cell
    }
}
