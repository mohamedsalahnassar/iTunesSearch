//
//  MediaItemsPresenterTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class MediaItemsPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: MediaItemsPresenter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupMediaItemsPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupMediaItemsPresenter() {
        sut = MediaItemsPresenter()
    }

    // MARK: Test doubles
    class MediaItemsDisplayLogicSpy: MediaItemsDisplayLogic {

        var invokedDisplayMediaItems = false
        var invokedDisplayMediaItemsCount = 0
        var invokedDisplayMediaItemsParameters: (viewModel: MediaItems.getMediaItems.ViewModel, Void)?
        var invokedDisplayMediaItemsParametersList = [(viewModel: MediaItems.getMediaItems.ViewModel, Void)]()

        func displayMediaItems(viewModel: MediaItems.getMediaItems.ViewModel) {
            invokedDisplayMediaItems = true
            invokedDisplayMediaItemsCount += 1
            invokedDisplayMediaItemsParameters = (viewModel, ())
            invokedDisplayMediaItemsParametersList.append((viewModel, ()))
        }
    }

    // MARK: Tests
    func testPresentMediaItems() {
        // Given
        let spy = MediaItemsDisplayLogicSpy()
        sut.viewController = spy
        let mediaItemsSample: [(MediaTypeEntity, [ItunesMedia])] = [(.album, [])]
        let response = MediaItems.getMediaItems.Response(mediaItems: mediaItemsSample)

        // When
        sut.presentMediaItems(response: response)

        // Then
        XCTAssertTrue(spy.invokedDisplayMediaItems)
    }
}
