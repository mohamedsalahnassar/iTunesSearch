//
//  UIImageViewExtension.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(url: URL?, placeholder: UIImage? = nil) {
        kf.indicatorType = .activity
        kf.setImage(with: url, placeholder: placeholder)
    }
}
