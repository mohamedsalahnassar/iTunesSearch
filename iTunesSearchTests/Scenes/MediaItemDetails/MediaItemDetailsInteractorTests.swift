//
//  MediaItemDetailsInteractorTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class MediaItemDetailsInteractorTests: XCTestCase {
    // MARK: Subject under test
    var sut: MediaItemDetailsInteractor!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMediaItemDetailsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupMediaItemDetailsInteractor() {
        let itunesMedia = ItunesMedia(
            collectionName: "test",
            artistName: "test",
            artistType: "test",
            shortDescription: "test",
            longDescription: "test",
            primaryGenreName: "test",
            trackName: "test",
            trackCensoredName: "test",
            artworkUrl30: nil,
            artworkUrl60: nil,
            artworkUrl100: URL(string: "https://is5-ssl.mzstatic.com/image/thumb/Music118/v4/f4/74/17/f47417a4-8078-50ba-d488-cd91b1805d87/source/100x100bb.jpg"),
            previewUrl: nil
        )
        sut = MediaItemDetailsInteractor(itunesMedia: itunesMedia)
    }

    // MARK: Test doubles
    class MediaItemDetailsPresentationLogicSpy: MediaItemDetailsPresentationLogic {

        var invokedPresentItemDetails = false
        var invokedPresentItemDetailsCount = 0
        var invokedPresentItemDetailsParameters: (response: MediaItemDetails.displayMediaItem.Response, Void)?
        var invokedPresentItemDetailsParametersList = [(response: MediaItemDetails.displayMediaItem.Response, Void)]()

        func presentItemDetails(response: MediaItemDetails.displayMediaItem.Response) {
            invokedPresentItemDetails = true
            invokedPresentItemDetailsCount += 1
            invokedPresentItemDetailsParameters = (response, ())
            invokedPresentItemDetailsParametersList.append((response, ()))
        }
    }

    // MARK: Tests
    func testGetItemDetails() {
        // Given
        let spy = MediaItemDetailsPresentationLogicSpy()
        sut.presenter = spy

        // When
        sut.getItemDetails()

        // Then
        XCTAssertTrue(spy.invokedPresentItemDetails)
    }
}
