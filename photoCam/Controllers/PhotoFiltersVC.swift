//
//  PhotoFiltersVC.swift
//  photoCam
//
//  Created by Mac on 8/2/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

protocol PhotoFilterViewControllerDelegate {
    func photoFilterDone()
    func photoFilterCancel()
}

class PhotoFiltersVC: UIViewController, FilterScrollViewDelegate, UIScrollViewDelegate  {

    var image: UIImage?
    var filtersService: FiltersServise!
    var delegate: PhotoFilterViewControllerDelegate?
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filtersScrollView: FiltersScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
  
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.delegate?.photoFilterCancel()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        guard let selectedimage = photoImageView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(selectedimage, self, #selector(image(_: didFinishSavingWithError:contextInfo:)), nil)
        self.delegate?.photoFilterDone()
    }
    
    @objc func image(_ image: UIImage,didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            print(error.localizedDescription)
        } else {
            self.delegate?.photoFilterDone()
        }
    }
    
    private func setup() {
        self.filtersService = FiltersServise()
        self.photoImageView.image = image
        self.filtersScrollView.filterDelegate = self
        self.filtersScrollView.delegate = self
    }


    func filterScrollViewDidSelectFilter(filter: CIFilter) {
        self.filtersService.applyFilter(filter: filter, to: image!) {
            self.photoImageView.image = $0
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
    }
}


