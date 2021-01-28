//
//  SearchFormWorker.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

class SearchFormWorker {
    func fetchResults(term: String, mediaTypes: [MediaType], completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            completion()
        }
    }
}
