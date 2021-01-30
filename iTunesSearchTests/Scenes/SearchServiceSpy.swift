//
//  SearchServiceSpy.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import Combine

class SearchServiceSpy: SearchService {

    var invokedSearch = false
    var invokedSearchCount = 0
    var invokedSearchParameters: (term: String, entity: String)?
    var invokedSearchParametersList = [(term: String, entity: String)]()
    var stubbedSearchResult: AnyPublisher<SearchResponse, Error>!

    func search(term: String, entity: String) -> AnyPublisher<SearchResponse, Error> {
        invokedSearch = true
        invokedSearchCount += 1
        invokedSearchParameters = (term, entity)
        invokedSearchParametersList.append((term, entity))
        return stubbedSearchResult
    }
}
