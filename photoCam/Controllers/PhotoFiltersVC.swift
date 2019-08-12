//
//  PhotoFiltersVC.swift
//  photoCam
//
//  Created by Mac on 8/2/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class PhotoFiltersVC: UIViewController, FilterScrollViewDelegate  {

    var image: UIImage?
    var filtersService: FiltersServise!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filtersScrollView: FiltersScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.filtersService = FiltersServise()
        self.photoImageView.image = image
        self.filtersScrollView.filterDelegate = self
    }


    func filterScrollViewDidSelectFilter(filter: CIFilter) {
        self.filtersService.applyFilter(filter: filter, to: image!) {
            self.photoImageView.image = $0
        }
    }
    
}
