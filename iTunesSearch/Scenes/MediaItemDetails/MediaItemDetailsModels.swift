//
//  MediaItemDetailsModels.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

enum MediaItemDetails {
    // MARK: Use cases
    enum displayMediaItem {
        struct Response {
            let mediaItem: ItunesMedia
        }
        struct ViewModel {
            let title: String
            let subtitle: String?
            let image: URL?
            let shortDescription: String?
            let longDescription: String?
            let previewURL: URL?

            init(from itunesMedia: ItunesMedia) {
                if itunesMedia.collectionName == nil && itunesMedia.trackName == nil && itunesMedia.trackCensoredName == nil {
                    self.title = itunesMedia.artistName ?? "No Title"
                    self.subtitle = itunesMedia.artistType
                } else {
                    self.title = itunesMedia.collectionName ?? itunesMedia.trackName ?? itunesMedia.trackCensoredName ?? "No Title"
                    self.subtitle = itunesMedia.artistName
                }
                self.image = itunesMedia.artworkUrl100
                self.shortDescription = itunesMedia.shortDescription
                self.longDescription = itunesMedia.longDescription
                self.previewURL = itunesMedia.previewUrl
            }
        }
    }
}
