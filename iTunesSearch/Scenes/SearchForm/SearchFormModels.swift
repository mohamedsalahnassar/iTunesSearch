//
//  SearchFormModels.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

enum SearchForm {
    // MARK: Use cases
    enum SelectMediaTypes {
        struct Request {
            var selectedMediaTypes: [String]
        }
        struct Response {
            var selectedMediaTypes: [MediaType]
        }
        struct ViewModel {
            var selectedMediaTypes: [String]
        }
    }
    enum Search {
        struct Request {
            var searchTerm: String?
            var mediaTypes: [MediaType]
        }
        struct Response {
            struct Error {
                let title: String
                let message: String
            }
        }
        struct ViewModel {
        }
    }
}
