//
//  PhotoListCollectionVC.swift
//  photoCam
//
//  Created by Mac on 8/2/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import Photos

class PhotoListCollectionVC: UICollectionViewController {
    
    private var images = [PHAsset]()

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
