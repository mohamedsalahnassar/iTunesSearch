//
//  SearchAPIService.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 28/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import Networking
import Combine

final class SearchAPIService: NetworkingService, SearchService {

    var network: NetworkingClient = NetworkingClient(baseURL: "https://itunes.apple.com")

    init() {
        #if DEBUG
        network.logLevels = .debug
        #endif
    }

    // Search
    func search(term: String, entity: String) -> AnyPublisher<SearchResponse, Error> {
        get("/search",
            params: [
                "term": term,
                "entity": entity
            ]
        )
    }
}
