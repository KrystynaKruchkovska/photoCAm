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
        print(AppContainerVC.identifier)
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
        guard let photoPreviewVC = storyboard?.instantiateViewController(withIdentifier: PhotoPreviewVC.identifier) as? PhotoPreviewVC else {
            fatalError("PhotoPreviewVC not found")
        }
        photoPreviewVC.previewImage = previewImage
        self.navigationController?.pushViewController(photoPreviewVC, animated: true)
    }
    
    private func showPhotoFiltersVC(for image: UIImage){
        guard let photoFiltersVC = self.storyboard?.instantiateViewController(withIdentifier: PhotoFiltersVC.identifier) as? PhotoFiltersVC else {
            fatalError("PhotoFiltersVC not found")
            
        }
        photoFiltersVC.image = image
        photoFiltersVC.delegate = self
        self.addChildController(photoFiltersVC)
    }
    
    private func showPhotosList() {
        self.view.subviews.forEach{
            $0.removeFromSuperview()
        }
        guard let photoListVC = self.storyboard?.instantiateViewController(withIdentifier: PhotoListCollectionVC.identifier) as? PhotoListCollectionVC else {
            return
        }
        photoListVC.delegate = self
        self.addChildController(photoListVC)
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

extension AppContainerVC: PhotoFilterViewControllerDelegate {
    func photoFilterDone() {
        showPhotosList()
    }
    
    func photoFilterCancel() {
       
    }
    
    
}
