//
//  PhotoListCollectionVC.swift
//  photoCam
//
//  Created by Mac on 8/2/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Photos

protocol PhotolistCollectionViewControllerDelegate {
    func photoListDidSelectImage(selectedImage: UIImage)
}
class PhotoListCollectionVC: UICollectionViewController {
    
    private var images = [PHAsset]()
    var delegate: PhotolistCollectionViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        populatePhotos()
        // Do any additional setup after loading the view.
    }

    func requestPermission(complition: @escaping (PHAuthorizationStatus) -> ()) {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async {
                complition(status)
            }
        }
    }
    
    
    func populatePhotos() {
        requestPermission { [weak self] (status) in
            if status == .authorized {
                let asset = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                asset.enumerateObjects({ (object, count, stop) in
                    self?.images.append(object)
                })
                self?.images.reverse()
                self?.collectionView.reloadData()
                print(self?.images)
            }
        }
    }
}

extension PhotoListCollectionVC  {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell is not found")
        }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { (image, _) in
            DispatchQueue.main.async {
                cell.photoImgView.image = image
            }
        }
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        
        manager.requestImage(for: asset, targetSize: CGSize(width: 320, height: 480), contentMode: .aspectFill, options: options) { (image, _) in
            if let image = image {
                self.delegate?.photoListDidSelectImage(selectedImage: image)
            }
        }
    }
}
