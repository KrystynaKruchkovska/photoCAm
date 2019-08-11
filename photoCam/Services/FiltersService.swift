//
//  FiltersService.swift
//  photoCam
//
//  Created by Krystyna Kruchkovska on 8/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import CoreImage

class FiltersServise {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func all() -> [CIFilter] {
        //blur
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValue(5.0, forKey: kCIInputRadiusKey)
        
        //halftone
        let halftoneFilter = CIFilter(name: "CICMYKHalftone")!
        halftoneFilter.setValue(5.0, forKey: kCIInputRadiusKey)
        
        //monochrome
        let monochromeFilter = CIFilter(name: "CIColorMonochrome")!
        monochromeFilter.setValue(5.0, forKey: kCIInputRadiusKey)
        
        //crytallize
        let crytallizeFilter = CIFilter(name: "CICrytallize")!
        crytallizeFilter.setValue(5.0, forKey: kCIInputRadiusKey)
        
        //sepia
        let sepiaFilter = CIFilter(name: "CISepiaTone")!
        sepiaFilter.setValue(5.0, forKey: kCIInputRadiusKey)
        
        return[ blurFilter,halftoneFilter, monochromeFilter, crytallizeFilter, sepiaFilter ]
    }
}


