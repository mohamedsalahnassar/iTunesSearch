//
//  MediaItemGridCell.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import UIKit

class MediaItemGridCell: UICollectionViewCell {

    @IBOutlet private var posterImage: UIImageView!
    @IBOutlet private var title: UILabel!

    public func configureCell(title: String, imageURL: URL?) {
        self.posterImage.load(url: imageURL, placeholder: UIImage(named: "No-Image-Placeholder"))
        self.title.text = title
    }
}
