//
//  GalleryViewController.swift
//  SimpleGallery
//
//  Created by Nicolas Vignolo on 12/08/2019.
//  Copyright © 2019 Nicolas Vignolo. All rights reserved.
//

import Foundation
import UIKit
import IHProgressHUD

class GalleryViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var navigator: Navigator?
    var sessionViewModel = SessionViewModel()
    var imagesViewModel = ImagesViewModel()
    var imagePickerViewController = ImagePickerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigator = Navigator(sender: self)
        // Check if the current session is still valid. This will prevent a disabled user to use the app.
        self.sessionViewModel.isValidSession { [weak self] valid in
            if !valid {
                self?.signOut()
            }
        }
        // Configure UI
        self.configureView()
        // Bind UI to actions and status
        self.bind()
        // Fetch current images
        self.imagesViewModel.fetch()
    }
    
    func configureView() {
        self.title = "Gallery"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showImagePicker))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        
        self.collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        self.collectionView.collectionViewLayout = GalleryFlowLayout()
        
        // Add gesture to collection view. This way there is no need to add a protocol to the cell for now
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        longPressGesture.delaysTouchesBegan = true
        self.collectionView.addGestureRecognizer(longPressGesture)
        
        self.imagePickerViewController.completion = { [unowned self] image in
            if let image = image {
                self.uploadImage(image: image)
            }
        }
    }
    
    func bind() {
        self.imagesViewModel.images.bind { [unowned self] (_) in
            self.collectionView.reloadData()
        }
        self.imagesViewModel.fetching.bind { (fetching) in
            fetching ? IHProgressHUD.show() : IHProgressHUD.dismiss()
        }
        self.imagesViewModel.uploading.bind { (uploading) in
            uploading ? IHProgressHUD.show() : IHProgressHUD.dismiss()
        }
        self.imagesViewModel.deleting.bind { (deleting) in
            deleting ? IHProgressHUD.show() : IHProgressHUD.dismiss()
        }
    }
    
    /// Sign Out action. Sign Out the current user and navigate to sign in screen
    @objc func signOut() {
        self.sessionViewModel.signOut()
        self.navigator?.navigateToRoot()
    }
    
    @objc func showImagePicker() {
        self.navigator?.navigate(to: .custom(viewController: self.imagePickerViewController), mode: .present)
    }
    
    /// Handle UIGestureRecognizer
    @objc func handleGesture(gesture: UIGestureRecognizer) {
        guard gesture.state == .began else {
            return
        }
        
        if let indexPath = self.collectionView.indexPathForItem(at: gesture.location(in: gesture.view)) {
            let imageViewModel = self.imagesViewModel.image(at: indexPath.row)
            self.showActions(for: imageViewModel)
        }
    }
    
    /// Upload image action
    ///
    /// - Parameter image: UIImage to upload returned from the Image Picker
    func uploadImage(image: UIImage) {
        self.imagesViewModel.upload(image: image) { (error) in
            if error != nil {
                IHProgressHUD.showError(withStatus: error?.description)
            }
        }
    }
    
    /// Show Images action. TODO: Replace this with collection view edit mode
    ///
    /// - Parameter image: The to take action with
    func showActions(for image: ImageViewModel) {
        let actionController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
            self.deleteImage(image: image)
        }))
        actionController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.navigator?.navigate(to: .custom(viewController: actionController), mode: .present, animated: true)
    }
    
    /// Delete image action
    ///
    /// - Parameter image: ImageViewModel to delete
    func deleteImage(image: ImageViewModel) {
        self.imagesViewModel.delete(image: image) { (error) in
            if error != nil {
                IHProgressHUD.showError(withStatus: error?.description)
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as! ImageCollectionViewCell
        let imageViewModel = self.imagesViewModel.image(at: indexPath.row)
        cell.configure(viewModel: imageViewModel)
        return cell
    }
}

// MARK: - UICollectionViewDelegate.
extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageViewModel = self.imagesViewModel.image(at: indexPath.row)
        self.navigator?.navigate(to: .imageDetail(image: imageViewModel))
    }
}
