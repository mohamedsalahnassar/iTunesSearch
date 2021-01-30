//
//  MediaItemsInteractorTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class MediaItemsInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: MediaItemsInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupMediaItemsInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupMediaItemsInteractor() {
        sut = MediaItemsInteractor()
    }

    // MARK: Test doubles

    class MediaItemsPresentationLogicSpy: MediaItemsPresentationLogic {

        var invokedPresentMediaItems = false
        var invokedPresentMediaItemsCount = 0
        var invokedPresentMediaItemsParameters: (response: MediaItems.getMediaItems.Response, Void)?
        var invokedPresentMediaItemsParametersList = [(response: MediaItems.getMediaItems.Response, Void)]()

        func presentMediaItems(response: MediaItems.getMediaItems.Response) {
            invokedPresentMediaItems = true
            invokedPresentMediaItemsCount += 1
            invokedPresentMediaItemsParameters = (response, ())
            invokedPresentMediaItemsParametersList.append((response, ()))
        }
    }

    // MARK: Tests
    func testGetMediaItems() {
        // Given
        let spy = MediaItemsPresentationLogicSpy()
        sut.presenter = spy

        // When
        sut.getMediaItems()

        // Then
        XCTAssertTrue(spy.invokedPresentMediaItems)
    }
}
