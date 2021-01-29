//
//  MediaItemsInteractor.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

protocol MediaItemsBusinessLogic {
    func getMediaItems()
}

protocol MediaItemsDataStore {
    var mediaItems: [(MediaTypeEntity, [ItunesMedia])] { get set }
}

class MediaItemsInteractor: MediaItemsBusinessLogic, MediaItemsDataStore {
    var presenter: MediaItemsPresentationLogic?
    var mediaItems: [(MediaTypeEntity, [ItunesMedia])] = []

    // MARK: Do something
    func getMediaItems() {
        let response = MediaItems.getMediaItems.Response(mediaItems: mediaItems)
        presenter?.presentMediaItems(response: response)
    }
}
