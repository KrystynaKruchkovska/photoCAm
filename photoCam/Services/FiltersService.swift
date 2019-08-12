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
    
    func applyFilter(filter: CIFilter, to inputImage: UIImage, complition: @escaping ((UIImage) -> ())) {
        let sourceImage = CIImage(image: inputImage)
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
            let proccessedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
            complition(proccessedImage)
        }
    }
    
    static func all() -> [CIFilter] {
        //blur
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setValue(5.0, forKey: kCIInputRadiusKey)
   
        //halftone
        let halftoneFilter = CIFilter(name: "CICMYKHalftone")!
        halftoneFilter.setValue(5.0, forKey: kCIInputWidthKey)
        
        // crytallize
        let crystallizeFilter = CIFilter(name: "CICrystallize")!
        crystallizeFilter.setValue(5, forKey: kCIInputRadiusKey)
        
        // monochrome
        let monochromeFilter = CIFilter(name: "CIColorMonochrome")!
        monochromeFilter.setValue(CIColor(red: 0.7, green: 0.7, blue: 0.7), forKey: kCIInputColorKey)
        monochromeFilter.setValue(10, forKey: kCIInputIntensityKey)
        
        // sepia
        let sepiaFilter = CIFilter(name: "CISepiaTone")!
        sepiaFilter.setValue(10, forKey: kCIInputIntensityKey)
        
        
        return[ blurFilter,halftoneFilter, monochromeFilter, crystallizeFilter, sepiaFilter ]
    }
}


