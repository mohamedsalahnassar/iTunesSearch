//
//  MediaItemsModels.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

enum MediaItems {
    // MARK: Use cases
    enum getMediaItems {
        struct Response {
            let mediaItems: [(MediaTypeEntity, [ItunesMedia])]
        }
        struct ViewModel {
            struct MediaItemsSection {
                struct Media {
                    let title: String
                    let subtitle: String?
                    let image: URL?

                    init(from itunesMedia: ItunesMedia) {
                        if itunesMedia.collectionName == nil && itunesMedia.trackName == nil && itunesMedia.trackCensoredName == nil {
                            self.title = itunesMedia.artistName ?? "No Title"
                            self.subtitle = itunesMedia.artistType
                        } else {
                            self.title = itunesMedia.collectionName ?? itunesMedia.trackName ?? itunesMedia.trackCensoredName ?? "No Title"
                            self.subtitle = itunesMedia.artistName
                        }
                        self.image = itunesMedia.artworkUrl250
                    }
                }
                let title: String
                let mediaItems: [Media]
            }

            let mediaItemsSections: [MediaItemsSection]
        }
    }
}
