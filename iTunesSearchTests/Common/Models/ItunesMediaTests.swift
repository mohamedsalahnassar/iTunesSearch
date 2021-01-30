//
//  ItunesMediaTests.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class ItunesMediaTests: XCTestCase {
    // MARK: Subject Under Test
    var sut: ItunesMedia!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test cases
    func testValidComputedValueReturnedByArtworkUrl250() {
        // Given
        let artworkUrl100 = URL(string: "https://is5-ssl.mzstatic.com/image/100x100bb.jpg")
        let expectedValue = URL(string: "https://is5-ssl.mzstatic.com/image/250x250bb.jpg")

        // When
        sut = ItunesMedia(
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
            artworkUrl100: artworkUrl100,
            previewUrl: nil
        )

        // Then
        XCTAssert(sut.artworkUrl250 == expectedValue)
    }

    func testNilComputedValueReturnedByArtworkUrl250() {
        // Given

        // When
        sut = ItunesMedia(
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

        // Then
        XCTAssertNil(sut.artworkUrl250)
    }
}
