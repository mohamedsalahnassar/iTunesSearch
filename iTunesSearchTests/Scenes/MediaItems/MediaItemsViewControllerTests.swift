//
//  MediaItemsViewControllerTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class MediaItemsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    var sut: MediaItemsViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupMediaItemsViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupMediaItemsViewController() {
        sut = MediaItemsViewController(itemsToDisplay: [])
    }

    func loadView() {
        window.addSubview(sut.view)
        sut.viewWillAppear(true)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles
    class MediaItemsBusinessLogicSpy: MediaItemsBusinessLogic {
        var invokedGetMediaItems = false
        var invokedGetMediaItemsCount = 0

        func getMediaItems() {
            invokedGetMediaItems = true
            invokedGetMediaItemsCount += 1
        }
    }

    class CollectionViewSpy: UICollectionView {
        // MARK: Method call expectations
        var reloadDataCalled = false

        // MARK: Spied methods
        override func reloadData() {
            reloadDataCalled = true
        }
    }

    // MARK: Tests
    func testInitializingFromCoderShouldGiveNil() {
        // Given
        sut = MediaItemsViewController(coder: NSCoder())

        // When

        // Then
        XCTAssertNil(sut)
    }

    func testShouldGetMediaItemsWhenViewIsLoaded() {
        // Given
        let spy = MediaItemsBusinessLogicSpy()
        sut.interactor = spy

        // When
        loadView()

        // Then
        XCTAssertTrue(spy.invokedGetMediaItems)
    }

    func testDisplayMediaItems() {
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
            artworkUrl100: nil,
            previewUrl: nil
        )
        let media = MediaItems.getMediaItems.ViewModel.MediaItemsSection.Media(from: itunesMedia)
        let mediaItemsSection = MediaItems.getMediaItems.ViewModel.MediaItemsSection(title: "test", mediaItems: [media])
        let viewModel = MediaItems.getMediaItems.ViewModel(mediaItemsSections: [mediaItemsSection])

        // When
        loadView()
        sut.displayMediaItems(viewModel: viewModel)

        // Then
        XCTAssertEqual(sut.collectionView.numberOfSections, 1)
        XCTAssertEqual(sut.collectionView.numberOfItems(inSection: 0), 1)
    }
}
