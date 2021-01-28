//
//  CollectionViewCellExtension.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import UIKit

extension UICollectionViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}
