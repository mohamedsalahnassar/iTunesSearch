//
//  MediaItemsRouter.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

@objc protocol MediaItemsRoutingLogic {
    func routeToItemDetailsView(forItemAt indexPath: IndexPath)
}

protocol MediaItemsDataPassing {
    var dataStore: MediaItemsDataStore? { get }
}

class MediaItemsRouter: NSObject, MediaItemsRoutingLogic, MediaItemsDataPassing {
    weak var viewController: MediaItemsViewController?
    var dataStore: MediaItemsDataStore?

    // MARK: Routing
    func routeToItemDetailsView(forItemAt indexPath: IndexPath) {
        let selectedSection = viewController?.collectionView.indexPathsForSelectedItems?.first?.section
        let selectedItem = viewController?.collectionView.indexPathsForSelectedItems?.first?.item
        let itunesMedia = dataStore!.mediaItems[selectedSection!].1[selectedItem!]
        let destinationVC = MediaItemDetailsViewController(itunesMedia: itunesMedia)
        viewController?.show(destinationVC, sender: nil)
    }
}
