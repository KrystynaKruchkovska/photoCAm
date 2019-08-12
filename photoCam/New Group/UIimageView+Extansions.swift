//
//  UIimageView+Extansions.swift
//  photoCam
//
//  Created by Krystyna Kruchkovska on 8/11/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

extension UIImageView {
    static func imageForFilterView() -> UIImageView {
        let filterIamgeView = UIImageView(image: UIImage(named: "defaulImg"))
        filterIamgeView.frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
        filterIamgeView.layer.cornerRadius = 6.0
        filterIamgeView.layer.masksToBounds = true
        return filterIamgeView
    }
}
