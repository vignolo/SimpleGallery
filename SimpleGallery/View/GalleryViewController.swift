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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let navigator = Navigator()
    var session = Session()
    var imagesViewModel = ImagesViewModel()
    var imagePickerViewController = ImagePickerViewController()
    var activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
        self.bind()
    }
    
    func configureView() {
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showImagePicker))
        self.navigationItem.rightBarButtonItem = addButtonItem
        
        self.imagePickerViewController.completion = { image in
            if let image = image {
                self.uploadImage(image: image)
            }
        }
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
        
        self.imagesViewModel.fetch()
//        if self.session.valid {
//            self.imagesViewModel.fetch()
//        } else {
//            self.navigator.navigate(to: .login, mode: .present, sender: self)
//        }
    }
    
    @objc func showImagePicker() {
        print("add button")
        self.navigator.navigate(to: .custom(viewController: self.imagePickerViewController), mode: .present, sender: self)
    }
    
    func uploadImage(image: UIImage) {
        ImageUploader().uploadImage(image: image) { success in
            //
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
