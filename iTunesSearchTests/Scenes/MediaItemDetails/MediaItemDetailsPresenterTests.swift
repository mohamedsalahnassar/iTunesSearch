//
//  MediaItemDetailsPresenterTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class MediaItemDetailsPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: MediaItemDetailsPresenter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMediaItemDetailsPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupMediaItemDetailsPresenter() {
        sut = MediaItemDetailsPresenter()
    }

    // MARK: Test doubles
    class MediaItemDetailsDisplayLogicSpy: MediaItemDetailsDisplayLogic {

        var invokedDisplayItemDetails = false
        var invokedDisplayItemDetailsCount = 0
        var invokedDisplayItemDetailsParameters: (viewModel: MediaItemDetails.displayMediaItem.ViewModel, Void)?
        var invokedDisplayItemDetailsParametersList = [(viewModel: MediaItemDetails.displayMediaItem.ViewModel, Void)]()

        func displayItemDetails(viewModel: MediaItemDetails.displayMediaItem.ViewModel) {
            invokedDisplayItemDetails = true
            invokedDisplayItemDetailsCount += 1
            invokedDisplayItemDetailsParameters = (viewModel, ())
            invokedDisplayItemDetailsParametersList.append((viewModel, ()))
        }
    }

    // MARK: Tests
    func testPresentItemDetails() {
        // Given
        let spy = MediaItemDetailsDisplayLogicSpy()
        sut.viewController = spy
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
        let response = MediaItemDetails.displayMediaItem.Response(mediaItem: itunesMedia)

        // When
        sut.presentItemDetails(response: response)

        // Then
        XCTAssertTrue(spy.invokedDisplayItemDetails)
    }
}
