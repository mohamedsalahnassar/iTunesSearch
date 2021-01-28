//
//  SearchService.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 28/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import Combine

protocol SearchService {
    func search(term: String, entity: String) -> AnyPublisher<SearchResponse, Error>
}
