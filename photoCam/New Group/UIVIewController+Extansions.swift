//
//  UIVIewController+Extansions.swift
//  photoCam
//
//  Created by Mac on 8/2/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func addChildController(_ childVC:UIViewController) {
        
        self.addChild(childVC)
        childVC.view.frame = self.view.frame
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
        
    }
    
    static var identifier: String {
        return "\(self)"
    }
}
