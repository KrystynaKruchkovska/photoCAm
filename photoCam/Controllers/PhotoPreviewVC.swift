//
//  PhotoPreviewVC.swift
//  photoCam
//
//  Created by Krystyna Kruchkovska on 8/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class PhotoPreviewVC: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var previewImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoImageView.image = previewImage
    }

}
