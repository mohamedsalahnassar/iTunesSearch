//
//  Media.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 28/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import Foundation
import Networking

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let resultCount: Int?
    let errorMessage: String?
    let results: [Media]?
}

extension SearchResponse: NetworkingJSONDecodable {}

// MARK: - Media
struct Media: Codable {
    let collectionName: String?
    let artistName: String?
    let shortDescription: String?
    let longDescription: String?
    let primaryGenreName: String?
    let trackName: String?
    let trackCensoredName: String?
    let releaseDate: Date?

    let artworkUrl30: URL?
    let artworkUrl60: URL?
    let artworkUrl100: URL?
    let previewURL: String?
}

extension Media: NetworkingJSONDecodable {}
