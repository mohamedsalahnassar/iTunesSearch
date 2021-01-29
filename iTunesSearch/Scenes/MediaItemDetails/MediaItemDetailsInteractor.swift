//
//  MediaItemDetailsInteractor.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

protocol MediaItemDetailsBusinessLogic {
    func getItemDetails()
}

protocol MediaItemDetailsDataStore {
    var itunesMedia: ItunesMedia { get set }
}

class MediaItemDetailsInteractor: MediaItemDetailsBusinessLogic, MediaItemDetailsDataStore {
    var presenter: MediaItemDetailsPresentationLogic?
    var itunesMedia: ItunesMedia

    init(itunesMedia: ItunesMedia) {
        self.itunesMedia = itunesMedia
    }

    // MARK: Get Item Details
    func getItemDetails() {
        let response = MediaItemDetails.displayMediaItem.Response(mediaItem: itunesMedia)
        presenter?.presentItemDetails(response: response)
    }
}
