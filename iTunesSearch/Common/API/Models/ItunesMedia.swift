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
    let previewUrl: URL?
    var artworkUrl250: URL? {
        if let urlString = artworkUrl100?.absoluteString {
            let replacedString = urlString.replacingOccurrences(of: "100x100", with: "250x250")
            return URL(string: replacedString)
        }
        return nil
    }
}
