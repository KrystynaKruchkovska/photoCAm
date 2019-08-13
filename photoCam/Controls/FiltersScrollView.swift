//
//  FiltersScrollView.swift
//  photoCam
//
//  Created by Krystyna Kruchkovska on 8/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit
import CoreImage

protocol FilterScrollViewDelegate {
    func filterScrollViewDidSelectFilter(filter:CIFilter)
    
}

class FiltersScrollView: UIScrollView {
    

    var filterDelegate: FilterScrollViewDelegate?
    private var filtersService: FiltersServise!
    
    override var frame: CGRect {
        didSet {
            print("||| SCROLL FRAME:\(frame)")
        }
    }
    
    init(parentView: UIView, frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.filtersService = FiltersServise()
        setupFilters()
    }
    
    private func registerTapGestureRecognizer(for view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        guard let selectedFilterImageView = recognizer.view as? UIImageView else {
            return
        }
        filterDelegate?.filterScrollViewDidSelectFilter(filter: FiltersServise.all()[selectedFilterImageView.tag])
    }
    
    private func setupFilters() {
        var offset: CGFloat  = 10.0
        
        for (index, filter) in FiltersServise.all().enumerated() {
            
            let filterImageView = UIImageView.imageForFilterView()
            registerTapGestureRecognizer(for: filterImageView)
            self.addSubview(filterImageView)
            filterImageView.tag = index
            filterImageView.isUserInteractionEnabled = true
            filterImageView.frame.origin.x = offset
            filterImageView.center.y = self.frame.size.height / 2 - 10//(initial offset)
            
            offset += filterImageView.frame.size.width + filterImageView.frame.size.width / 4
            self.contentSize = CGSize(width: offset, height: self.frame.height)
            
            self.filtersService.applyFilter(filter: filter, to: filterImageView.image!) {
                filterImageView.image = $0
            }
        }
        
    }
    
}


