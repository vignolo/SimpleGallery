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
        self.sessionViewModel.isValidSession { [weak self] valid in
            if !valid {
                self?.signOut()
            }
        }
        self.configureView()
        self.bind()
        self.imagesViewModel.fetch()
    }
    
    func configureView() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showImagePicker))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        
        self.collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        self.collectionView.collectionViewLayout = GalleryFlowLayout()
        
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
        self.imagesViewModel.fetching.bind { [unowned self] (fetching) in
            fetching ? IHProgressHUD.show() : IHProgressHUD.dismiss()
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
        IHProgressHUD.show()
        ImageWorker().uploadAndSave(image: image) { [weak self] image in
            if image != nil {
                self?.imagesViewModel.fetch()
                return
            }
            IHProgressHUD.showError(withStatus: "Error uploading the image")
        }
    }
    
}

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
