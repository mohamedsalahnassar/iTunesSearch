//
//  ItunesMedia.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 28/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import Foundation
import Networking

// MARK: - ItuneMedia
struct ItunesMedia: Codable {
    let collectionName: String?
    let artistName: String?
    let artistType: String?
    let shortDescription: String?
    let longDescription: String?
    let primaryGenreName: String?
    let trackName: String?
    let trackCensoredName: String?

    let artworkUrl30: URL?
    let artworkUrl60: URL?
    let artworkUrl100: URL?
    let previewURL: URL?
}
