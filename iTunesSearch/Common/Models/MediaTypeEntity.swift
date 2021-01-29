//
//  MediaTypeEntity.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 28/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import Foundation

enum MediaTypeEntity: String, CaseIterable, CustomStringConvertible {
    case movie, album, allArtist, audiobook, podcast, allTrack, musicVideo, tvSeason

    var description: String {
        switch self {
        case .movie: return "Movie"
        case .album: return "Album"
        case .allArtist: return "Artist"
        case .audiobook: return "Book"
        case .podcast: return "Podcast"
        case .allTrack: return "Music"
        case .musicVideo: return "Music Video"
        case .tvSeason: return "TV Season"
        }
    }
}
