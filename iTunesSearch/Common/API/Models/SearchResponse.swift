//
//  SearchResponse.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

import Foundation
import Networking

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let resultCount: Int?
    let errorMessage: String?
    let results: [ItunesMedia]?
}

extension SearchResponse: NetworkingJSONDecodable {}
