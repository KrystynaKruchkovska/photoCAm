//
//  AppContainerVC.swift
//  photoCam
//
//  Created by Mac on 8/2/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class AppContainerVC: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photoListVC = self.children.first as? PhotoListCollectionVC else {
            return
        }
        photoListVC.delegate = self
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    private func showImagePreview(_ previewImage: UIImage){
        guard let photoPreviewVC = storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewVC") as? PhotoPreviewVC else {
            fatalError("PhotoPreviewVC not found")
        }
        photoPreviewVC.previewImage = previewImage
        self.navigationController?.pushViewController(photoPreviewVC, animated: true)
    }
    
    private func showPhotoFiltersVC(for image: UIImage){
        guard let photoFiltersVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoFiltersVC") as? PhotoFiltersVC else {
            fatalError("PhotoFiltersVC not found")
            
        }
        photoFiltersVC.image = image
        self.addChildController(photoFiltersVC)
    }
}

extension AppContainerVC: PhotolistCollectionViewControllerDelegate {
    func photoListDidSelectImage(selectedImage: UIImage) {
        showImagePreview(selectedImage)
    }
}

extension AppContainerVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        showPhotoFiltersVC(for: originalImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
