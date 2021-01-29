//
//  MediaSectionHeaderView.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import UIKit

class MediaSectionHeaderView: UICollectionReusableView {
    @IBOutlet private var title: UILabel!

    public func configureHeader(with title: String) {
        self.title.text = title
    }
}
