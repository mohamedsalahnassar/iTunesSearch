//
//  MediaType.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 28/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import Foundation

enum MediaType: String, CaseIterable, CustomStringConvertible {
    case Album, Artist, Book, Movie, Podcast, Song
    case MusicVideo = "Music Video"

    var description: String {
        return rawValue
    }
}
