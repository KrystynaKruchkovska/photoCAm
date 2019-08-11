//
//  AppContainerVC.swift
//  photoCam
//
//  Created by Mac on 8/2/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class AppContainerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photoListVC = self.children.first as? PhotoListCollectionVC else {
            return
        }
        photoListVC.delegate = self
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        guard let photoFiltersVC = storyboard?.instantiateViewController(withIdentifier: "PhotoFiltersVC") as? PhotoFiltersVC else {
            fatalError("PhotoFiltersVC is not found")
        }
        
        self.addChildController(photoFiltersVC)
    }
    
    private func showImagePreview(_ previewImage: UIImage){
        guard let photoPreviewVC = storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewVC") as? PhotoPreviewVC else {
            fatalError("PhotoPreviewVC not found")
        }
        photoPreviewVC.previewImage = previewImage
        self.navigationController?.pushViewController(photoPreviewVC, animated: true)
    }
}

extension AppContainerVC: PhotolistCollectionViewControllerDelegate {
    func photoListDidSelectImage(selectedImage: UIImage) {
        showImagePreview(selectedImage)
    }
    
    
}
