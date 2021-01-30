//
//  MediaTypeEntityTests.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class MediaTypeEntityTests: XCTestCase {

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test cases
    func testEnumHasGotCorrectDescription() {
        // Given
        let movieType = MediaTypeEntity.movie
        let albumType = MediaTypeEntity.album
        let allArtistType = MediaTypeEntity.allArtist
        let audiobookType = MediaTypeEntity.audiobook
        let podcastType = MediaTypeEntity.podcast
        let allTrackType = MediaTypeEntity.allTrack
        let musicVideoType = MediaTypeEntity.musicVideo
        let tvSeasonType = MediaTypeEntity.tvSeason

        // Then
        XCTAssertEqual(movieType.description, "Movie")
        XCTAssertEqual(albumType.description, "Album")
        XCTAssertEqual(allArtistType.description, "Artist")
        XCTAssertEqual(audiobookType.description, "Book")
        XCTAssertEqual(podcastType.description, "Podcast")
        XCTAssertEqual(allTrackType.description, "Music")
        XCTAssertEqual(musicVideoType.description, "Music Video")
        XCTAssertEqual(tvSeasonType.description, "TV Season")

    }
}
