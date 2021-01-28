//
//  SearchFormWorker.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

class SearchFormWorker {
    let searchService: SearchService

    internal init(searchService: SearchService) {
        self.searchService = searchService
    }

    func fetchResults(term: String, mediaTypes: [MediaType], completion: @escaping () -> Void) {
        for mediaType in mediaTypes {
            searchService.search(term: term, entity: mediaType.rawValue)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
    }
}
