//
//  MediaItemsPresenter.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

protocol MediaItemsPresentationLogic {
    func presentMediaItems(response: MediaItems.getMediaItems.Response)
}

class MediaItemsPresenter: MediaItemsPresentationLogic {
    weak var viewController: MediaItemsDisplayLogic?

    // MARK: Display Media Items
    func presentMediaItems(response: MediaItems.getMediaItems.Response) {
        let viewModel = MediaItems.getMediaItems.ViewModel(mediaItemsSections: response.mediaItems.map({ (tuple) in
            let mediaTypeEntity: MediaTypeEntity = tuple.0
            let itunesMediaItems: [ItunesMedia] = tuple.1
            let mediaItems: [MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media] = itunesMediaItems.map({MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media(from: $0)})
            return MediaItems.getMediaItems.ViewModel.MediaItemsSection(title: mediaTypeEntity.description, mediaItems: mediaItems)
        }))
        viewController?.displayMediaItems(viewModel: viewModel)
    }
}
