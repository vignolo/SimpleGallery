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
    
    private var navigator: Navigator?
    var sessionViewModel = SessionViewModel()
    var imagesViewModel = ImagesViewModel()
    var imagePickerViewController = ImagePickerViewController()
    var activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigator = Navigator(sender: self)
        self.sessionViewModel.isValidSession { [weak self] valid in
            if !valid {
                self?.signOut()
            }
        }
        self.configureView()
        self.bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.imagesViewModel.fetch()
    }
    
    func configureView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showImagePicker))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        
        self.imagePickerViewController.completion = { [weak self] image in
            if let image = image {
                self?.uploadImage(image: image)
            }
        }
    }
    
    func bind() {
        self.imagesViewModel.images.bind { [unowned self] (_) in
            self.collectionView.reloadData()
        }
        self.imagesViewModel.fetching.bind { [unowned self] (fetching) in
            self.activityIndicatorView.isHidden = !fetching
        }
    }
    
    @objc func signOut() {
        self.sessionViewModel.signOut()
        self.navigator?.navigateToRoot()
    }
    
    @objc func showImagePicker() {
        self.navigator?.navigate(to: .custom(viewController: self.imagePickerViewController), mode: .present)
    }
    
    func uploadImage(image: UIImage) {
        ImageWorker().uploadImage(image: image) { [weak self] image in
            if let image = image {
                // Success. Show error and reload list
                self?.imagesViewModel.fetch()
                print("Image uploaded \(image.thumbnail)")
                return
            }
            // Show Error.
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
