//
//  SearchFormPresenterTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class SearchFormPresenterTests: XCTestCase {
    // MARK: Subject under test
    var sut: SearchFormPresenter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupSearchFormPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupSearchFormPresenter() {
        sut = SearchFormPresenter()
    }

    // MARK: Test doubles
    class SearchFormDisplayLogicSpy: SearchFormDisplayLogic {

        var invokedDisplaySelectedMediaTypes = false
        var invokedDisplaySelectedMediaTypesCount = 0
        var invokedDisplaySelectedMediaTypesParameters: (viewModel: SearchForm.SelectMediaTypes.ViewModel, Void)?
        var invokedDisplaySelectedMediaTypesParametersList = [(viewModel: SearchForm.SelectMediaTypes.ViewModel, Void)]()

        func displaySelectedMediaTypes(viewModel: SearchForm.SelectMediaTypes.ViewModel) {
            invokedDisplaySelectedMediaTypes = true
            invokedDisplaySelectedMediaTypesCount += 1
            invokedDisplaySelectedMediaTypesParameters = (viewModel, ())
            invokedDisplaySelectedMediaTypesParametersList.append((viewModel, ()))
        }

        var invokedSearch = false
        var invokedSearchCount = 0
        var invokedSearchParameters: (request: SearchForm.Search.Request, Void)?
        var invokedSearchParametersList = [(request: SearchForm.Search.Request, Void)]()

        func search(request: SearchForm.Search.Request) {
            invokedSearch = true
            invokedSearchCount += 1
            invokedSearchParameters = (request, ())
            invokedSearchParametersList.append((request, ()))
        }

        var invokedShowSearchResultsView = false
        var invokedShowSearchResultsViewCount = 0
        var invokedShowSearchResultsViewParameters: (fetchedData: [(MediaTypeEntity, [ItunesMedia])], Void)?
        var invokedShowSearchResultsViewParametersList = [(fetchedData: [(MediaTypeEntity, [ItunesMedia])], Void)]()

        func showSearchResultsView(fetchedData: [(MediaTypeEntity, [ItunesMedia])]) {
            invokedShowSearchResultsView = true
            invokedShowSearchResultsViewCount += 1
            invokedShowSearchResultsViewParameters = (fetchedData, ())
            invokedShowSearchResultsViewParametersList.append((fetchedData, ()))
        }

        var invokedShowErrorAlert = false
        var invokedShowErrorAlertCount = 0
        var invokedShowErrorAlertParameters: (title: String, message: String)?
        var invokedShowErrorAlertParametersList = [(title: String, message: String)]()

        func showErrorAlert(title: String, message: String) {
            invokedShowErrorAlert = true
            invokedShowErrorAlertCount += 1
            invokedShowErrorAlertParameters = (title, message)
            invokedShowErrorAlertParametersList.append((title, message))
        }

        var invokedShowInfoAlert = false
        var invokedShowInfoAlertCount = 0
        var invokedShowInfoAlertParameters: (title: String, message: String)?
        var invokedShowInfoAlertParametersList = [(title: String, message: String)]()

        func showInfoAlert(title: String, message: String) {
            invokedShowInfoAlert = true
            invokedShowInfoAlertCount += 1
            invokedShowInfoAlertParameters = (title, message)
            invokedShowInfoAlertParametersList.append((title, message))
        }

        var invokedShowLoadingIndicator = false
        var invokedShowLoadingIndicatorCount = 0

        func showLoadingIndicator() {
            invokedShowLoadingIndicator = true
            invokedShowLoadingIndicatorCount += 1
        }

        var invokedHideLoadingIndicator = false
        var invokedHideLoadingIndicatorCount = 0

        func hideLoadingIndicator() {
            invokedHideLoadingIndicator = true
            invokedHideLoadingIndicatorCount += 1
        }
    }

    // MARK: Tests
    func testDisplaySelectedMediaTypes() {
        // Given
        let spy = SearchFormDisplayLogicSpy()
        sut.viewController = spy
        let response = SearchForm.SelectMediaTypes.Response(selectedMediaTypes: [.album])

        // When
        sut.displaySelectedMediaTypes(response: response)

        // Then
        XCTAssertTrue(spy.invokedDisplaySelectedMediaTypes)
    }

    func testShowSearchResultsView() {
        // Given
        let spy = SearchFormDisplayLogicSpy()
        sut.viewController = spy
        let ituneMedia = ItunesMedia(collectionName: nil, artistName: nil, artistType: nil, shortDescription: nil, longDescription: nil, primaryGenreName: nil, trackName: nil, trackCensoredName: nil, artworkUrl30: nil, artworkUrl60: nil, artworkUrl100: nil, previewUrl: nil)

        // When
        sut.showResultsView(response: SearchForm.Search.Response(itunesMediaItems: [(MediaTypeEntity.album, [ituneMedia])]))

        // Then
        XCTAssertTrue(spy.invokedShowSearchResultsView)
    }

    func testShowErrorAlert() {
        // Given
        let spy = SearchFormDisplayLogicSpy()
        sut.viewController = spy
        let response = SearchForm.Search.Response.Error(title: "test", message: "test")

        // When
        sut.showErrorAlert(response: response)

        // Then
        XCTAssertTrue(spy.invokedShowErrorAlert)
    }

    func testShowInfoAlert() {
        // Given
        let spy = SearchFormDisplayLogicSpy()
        sut.viewController = spy
        let response = SearchForm.Search.Response.Error(title: "test", message: "test")

        // When
        sut.showInfoAlert(response: response)

        // Then
        XCTAssertTrue(spy.invokedShowInfoAlert)
    }

    func testShowLoadingIndicator() {
        // Given
        let spy = SearchFormDisplayLogicSpy()
        sut.viewController = spy

        // When
        sut.showLoadingIndicator()

        // Then
        XCTAssertTrue(spy.invokedShowLoadingIndicator)
    }

    func testHideLoadingIndicator() {
        // Given
        let spy = SearchFormDisplayLogicSpy()
        sut.viewController = spy

        // When
        sut.hideLoadingIndicator()

        // Then
        XCTAssertTrue(spy.invokedHideLoadingIndicator)
    }
}
