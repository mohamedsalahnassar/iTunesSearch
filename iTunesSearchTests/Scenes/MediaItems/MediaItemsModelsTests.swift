//
//  MediaItemsModelsTests.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class MediaItemsModelsTests: XCTestCase {
    // MARK: Subject under test
    var sut: MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests
    func testInitializerCase1() {
        // Given
        let itunesMediaSample = ItunesMedia(
            collectionName: "collectionName test",
            artistName: "artistName test",
            artistType: nil,
            shortDescription: nil,
            longDescription: nil,
            primaryGenreName: nil,
            trackName: nil,
            trackCensoredName: nil,
            artworkUrl30: nil,
            artworkUrl60: nil,
            artworkUrl100: nil,
            previewUrl: nil
        )

        // When
        sut = MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media(from: itunesMediaSample)

        // Then
        XCTAssertEqual(sut.title, itunesMediaSample.collectionName)
        XCTAssertEqual(sut.subtitle, itunesMediaSample.artistName)
        XCTAssertNil(sut.image)
    }

    func testInitializerCase2() {
        // Given
        let itunesMediaSample = ItunesMedia(
            collectionName: nil,
            artistName: "artistName test",
            artistType: "artistType test",
            shortDescription: nil,
            longDescription: nil,
            primaryGenreName: nil,
            trackName: nil,
            trackCensoredName: nil,
            artworkUrl30: nil,
            artworkUrl60: nil,
            artworkUrl100: nil,
            previewUrl: nil
        )

        // When
        sut = MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media(from: itunesMediaSample)

        // Then
        XCTAssertEqual(sut.title, itunesMediaSample.artistName)
        XCTAssertEqual(sut.subtitle, itunesMediaSample.artistType)
        XCTAssertNil(sut.image)
    }

    func testInitializerCase3() {
        // Given
        let itunesMediaSample = ItunesMedia(
            collectionName: nil,
            artistName: nil,
            artistType: "artistType test",
            shortDescription: nil,
            longDescription: nil,
            primaryGenreName: nil,
            trackName: nil,
            trackCensoredName: nil,
            artworkUrl30: nil,
            artworkUrl60: nil,
            artworkUrl100: nil,
            previewUrl: nil
        )

        // When
        sut = MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media(from: itunesMediaSample)

        // Then
        XCTAssertEqual(sut.title, "No Title")
        XCTAssertEqual(sut.subtitle, itunesMediaSample.artistType)
        XCTAssertNil(sut.image)
    }

    func testInitializerCase4() {
        // Given
        let itunesMediaSample = ItunesMedia(
            collectionName: nil,
            artistName: "artistName test",
            artistType: nil,
            shortDescription: nil,
            longDescription: nil,
            primaryGenreName: nil,
            trackName: "trackName test",
            trackCensoredName: nil,
            artworkUrl30: nil,
            artworkUrl60: nil,
            artworkUrl100: nil,
            previewUrl: nil
        )

        // When
        sut = MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media(from: itunesMediaSample)

        // Then
        XCTAssertEqual(sut.title, itunesMediaSample.trackName)
        XCTAssertEqual(sut.subtitle, itunesMediaSample.artistName)
        XCTAssertNil(sut.image)
    }

    func testInitializerCase5() {
        // Given
        let itunesMediaSample = ItunesMedia(
            collectionName: nil,
            artistName: "artistName test",
            artistType: nil,
            shortDescription: nil,
            longDescription: nil,
            primaryGenreName: nil,
            trackName: nil,
            trackCensoredName: "trackCensoredName test",
            artworkUrl30: nil,
            artworkUrl60: nil,
            artworkUrl100: nil,
            previewUrl: nil
        )

        // When
        sut = MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media(from: itunesMediaSample)

        // Then
        XCTAssertEqual(sut.title, itunesMediaSample.trackCensoredName)
        XCTAssertEqual(sut.subtitle, itunesMediaSample.artistName)
        XCTAssertNil(sut.image)
    }

    func testInitializerCase6() {
        // Given
        let itunesMediaSample = ItunesMedia(
            collectionName: nil,
            artistName: nil,
            artistType: nil,
            shortDescription: nil,
            longDescription: nil,
            primaryGenreName: nil,
            trackName: nil,
            trackCensoredName: nil,
            artworkUrl30: nil,
            artworkUrl60: nil,
            artworkUrl100: nil,
            previewUrl: nil
        )

        // When
        sut = MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media(from: itunesMediaSample)

        // Then
        XCTAssertEqual(sut.title, "No Title")
        XCTAssertEqual(sut.subtitle, itunesMediaSample.artistName)
        XCTAssertNil(sut.image)
    }

}
