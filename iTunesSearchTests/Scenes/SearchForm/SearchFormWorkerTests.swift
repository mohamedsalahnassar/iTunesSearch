//
//  SearchFormWorkerTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest
import Combine

class SearchFormWorkerTests: XCTestCase {
    // MARK: Subject under test
    var sut: SearchFormWorker!
    var searchServiceSpy: SearchServiceSpy!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        setupSearchFormWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup
    func setupSearchFormWorker() {
        searchServiceSpy = SearchServiceSpy()
        sut = SearchFormWorker(searchService: searchServiceSpy)
    }

    // MARK: Tests
    func testSuccessfulSearch() {
        // Given
        let expect = expectation(description: "expects results")
        let expectedSearchResults: [(MediaTypeEntity, [ItunesMedia])] = [(MediaTypeEntity.album, [])]
        let publisher = PassthroughSubject<SearchResponse, Error>()
        var fetchedSearchResults: [(MediaTypeEntity, [ItunesMedia])]?
        searchServiceSpy.stubbedSearchResult = publisher
            .eraseToAnyPublisher()

        // When
        sut.fetchResults(term: "test", for: [.album]) { (result) in
            switch result {
            case .failure:
                expect.fulfill()
            case .success(let fetchedResults):
                fetchedSearchResults = fetchedResults
                expect.fulfill()
            }
        }

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
        publisher.send(SearchResponse(resultCount: 0, errorMessage: nil, results: [itunesMedia]))
        publisher.send(completion: .finished)

        // Then
        DispatchQueue.main.async {
            XCTAssertTrue(self.searchServiceSpy.invokedSearch)
            XCTAssertNotNil(fetchedSearchResults)
            XCTAssert(!(fetchedSearchResults?.isEmpty ?? true))
            XCTAssert(fetchedSearchResults?.first?.0 == expectedSearchResults.first?.0)
        }

        wait(for: [expect], timeout: 1)
    }

    func testFailingSearch() {
        // Given
        let expect = expectation(description: "Expects Failure")
        let publisher = PassthroughSubject<SearchResponse, Error>()
        let expectedError: NSError = NSError(domain: "test", code: 0, userInfo: nil)
        var returnedError: NSError?

        searchServiceSpy.stubbedSearchResult = publisher
            .eraseToAnyPublisher()

        // When
        sut.fetchResults(term: "test", for: [.album]) { (result) in
            switch result {
            case .failure(let error):
                returnedError = error as NSError
                expect.fulfill()
            case .success: break
            }
        }

        publisher.send(completion: .failure(expectedError))
        publisher.send(completion: .finished)

        // Then
        wait(for: [expect], timeout: 1)

        XCTAssertTrue(self.searchServiceSpy.invokedSearch)
        XCTAssertNotNil(returnedError)
        XCTAssertEqual(returnedError, expectedError)
    }
}
