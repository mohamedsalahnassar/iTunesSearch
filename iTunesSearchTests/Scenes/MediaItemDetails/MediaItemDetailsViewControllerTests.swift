//
//  MediaItemDetailsViewControllerTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class MediaItemDetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: MediaItemDetailsViewController!
    var window: UIWindow!
    var sampleItunesMedia: ItunesMedia!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMediaItemDetailsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupMediaItemDetailsViewController() {
        sampleItunesMedia = ItunesMedia(
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
            artworkUrl100: nil,
            previewUrl: nil
        )
        sut = MediaItemDetailsViewController(itunesMedia: sampleItunesMedia)
    }

    func loadView() {
        window.addSubview(sut.view)
        sut.viewWillAppear(true)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles
    class MediaItemDetailsBusinessLogicSpy: MediaItemDetailsBusinessLogic {

        var invokedGetItemDetails = false
        var invokedGetItemDetailsCount = 0

        func getItemDetails() {
            invokedGetItemDetails = true
            invokedGetItemDetailsCount += 1
        }
    }

    // MARK: Tests
    func testInitializingFromCoderShouldGiveNil() {
        // Given
        sut = MediaItemDetailsViewController(coder: NSCoder())

        // When

        // Then
        XCTAssertNil(sut)
    }

    func testShouldGetMediaItemDetailsWhenViewIsLoaded() {
        // Given
        let spy = MediaItemDetailsBusinessLogicSpy()
        sut.interactor = spy

        // When
        loadView()

        // Then
        XCTAssertTrue(spy.invokedGetItemDetails)
    }

    func testDisplayItemDetails() {
        // Given
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
        let viewModel = MediaItemDetails.displayMediaItem.ViewModel(from: itunesMedia)

        // When
        loadView()
        sut.displayItemDetails(viewModel: viewModel)

        // Then
        XCTAssertEqual(sut.itemTitle.text, viewModel.title)
        XCTAssertEqual(sut.itemSubtitle.text, viewModel.subtitle)
        XCTAssertEqual(sut.longDescription.text, viewModel.longDescription)
        XCTAssertNotNil(sut.posterImage.image)
        XCTAssertNotNil(sut.backgroundImage.image)
        XCTAssertTrue(sut.playPreviewButton.isHidden)
    }

}
