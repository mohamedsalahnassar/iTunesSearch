//
//  SearchFormInteractorTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class SearchFormInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: SearchFormInteractor!

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupSearchFormInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupSearchFormInteractor() {
        sut = SearchFormInteractor()
    }

    // MARK: Test doubles
    class SearchFormPresentationLogicSpy: SearchFormPresentationLogic {

        func displaySelectedMediaTypes(response: SearchForm.SelectMediaTypes.Response) {}

        var invokedShowResultsView = false
        var invokedShowResultsViewCount = 0
        var invokedShowResultsViewParameters: (response: SearchForm.Search.Response, Void)?
        var invokedShowResultsViewParametersList = [(response: SearchForm.Search.Response, Void)]()

        func showResultsView(response: SearchForm.Search.Response) {
            invokedShowResultsView = true
            invokedShowResultsViewCount += 1
            invokedShowResultsViewParameters = (response, ())
            invokedShowResultsViewParametersList.append((response, ()))
        }

        var invokedShowInfoAlert = false
        var invokedShowInfoAlertCount = 0
        var invokedShowInfoAlertParameters: (response: SearchForm.Search.Response.Error, Void)?
        var invokedShowInfoAlertParametersList = [(response: SearchForm.Search.Response.Error, Void)]()

        func showInfoAlert(response: SearchForm.Search.Response.Error) {
            invokedShowInfoAlert = true
            invokedShowInfoAlertCount += 1
            invokedShowInfoAlertParameters = (response, ())
            invokedShowInfoAlertParametersList.append((response, ()))
        }

        var invokedShowErrorAlert = false
        var invokedShowErrorAlertCount = 0
        var invokedShowErrorAlertParameters: (response: SearchForm.Search.Response.Error, Void)?
        var invokedShowErrorAlertParametersList = [(response: SearchForm.Search.Response.Error, Void)]()

        func showErrorAlert(response: SearchForm.Search.Response.Error) {
            invokedShowErrorAlert = true
            invokedShowErrorAlertCount += 1
            invokedShowErrorAlertParameters = (response, ())
            invokedShowErrorAlertParametersList.append((response, ()))
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

    class SearchFormWorkerStub: SearchFormWorker {
        override func fetchResults(term: String, for mediaTypes: [MediaTypeEntity], completionHandler: @escaping (Result<[(MediaTypeEntity, [ItunesMedia])], Error>) -> Void) {
            let expectedResult: [(MediaTypeEntity, [ItunesMedia])] = mediaTypes.map({ ($0, []) })
            completionHandler(Result.success(expectedResult))
        }
    }

    // MARK: Tests
    func testShowTermEmptyValidationAlert() {
        // Given
        let spy = SearchFormPresentationLogicSpy()
        sut.presenter = spy
        let request = SearchForm.Search.Request(searchTerm: "", mediaTypes: [])

        // When
        sut.search(request: request)

        // Then
        XCTAssertTrue(spy.invokedShowInfoAlert)
    }

    func testShowMediaTypesEmptyValidationAlert() {
        // Given
        let spy = SearchFormPresentationLogicSpy()
        sut.presenter = spy
        let request = SearchForm.Search.Request(searchTerm: "", mediaTypes: [])

        // When
        sut.search(request: request)

        // Then
        XCTAssertTrue(spy.invokedShowInfoAlert)
    }

    func testShouldInvokeShowLoading() {
        // Given
        let spy = SearchFormPresentationLogicSpy()
        let worker = SearchFormWorkerStub(searchService: SearchServiceSpy())
        sut.presenter = spy
        sut.worker = worker

        let request = SearchForm.Search.Request(searchTerm: "Test", mediaTypes: [.album])

        // When
        sut.search(request: request)

        // Then
        XCTAssertTrue(spy.invokedShowLoadingIndicator)
    }
}
