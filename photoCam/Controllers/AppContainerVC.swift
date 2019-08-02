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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        guard let photoFiltersVC = storyboard?.instantiateViewController(withIdentifier: "PhotoFiltersVC") as? PhotoFiltersVC else {
            fatalError("PhotoFiltersVC is not found")
        }
        
        self.addChildController(photoFiltersVC)
    }
}
