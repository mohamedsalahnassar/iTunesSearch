//
//  MediaItemDetailsPresenter.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

protocol MediaItemDetailsPresentationLogic {
    func presentItemDetails(response: MediaItemDetails.displayMediaItem.Response)
}

class MediaItemDetailsPresenter: MediaItemDetailsPresentationLogic {
    weak var viewController: MediaItemDetailsDisplayLogic?

    // MARK: Present Item Details
    func presentItemDetails(response: MediaItemDetails.displayMediaItem.Response) {
        let viewModel = MediaItemDetails.displayMediaItem.ViewModel(from: response.mediaItem)
        viewController?.displayItemDetails(viewModel: viewModel)
    }
}
