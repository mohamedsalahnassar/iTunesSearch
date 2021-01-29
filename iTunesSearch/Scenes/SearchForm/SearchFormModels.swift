//
//  SearchFormModels.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

enum SearchForm {
    // MARK: Use cases
    enum SelectMediaTypes {
        struct Request {
            var selectedMediaTypes: [MediaTypeEntity]
        }
        struct Response {
            var selectedMediaTypes: [MediaTypeEntity]
        }
        struct ViewModel {
            var selectedMediaTypes: [MediaTypeEntity]
        }
    }
    enum Search {
        struct Request {
            var searchTerm: String?
            var mediaTypes: [MediaTypeEntity]
        }
        struct Response {
            struct Error {
                let title: String
                let message: String
            }
        }
        struct ViewModel {
            struct Media {
                let collectionName: String?
                let artistName: String?
                let shortDescription: String?
                let longDescription: String?
                let primaryGenreName: String?
                let trackName: String?
                let trackCensoredName: String?

                let artworkUrl30: URL?
                let artworkUrl60: URL?
                let artworkUrl100: URL?
                let previewURL: String?
            }

            let mediaResults: [(String, [ViewModel.Media])]
        }
    }
}
