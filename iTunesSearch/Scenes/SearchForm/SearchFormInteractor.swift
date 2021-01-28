//
//  SearchFormInteractor.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

protocol SearchFormBusinessLogic {
    func setInitialSelectedMediaTypes(request: SearchForm.SelectMediaTypes.Request)
    func search(request: SearchForm.Search.Request)
}

protocol SearchFormDataStore {
     var selectedMediaTypes: [MediaType] { get set }
}

class SearchFormInteractor: SearchFormBusinessLogic, SearchFormDataStore {
    var presenter: SearchFormPresentationLogic?
    var worker: SearchFormWorker?
    var selectedMediaTypes: [MediaType] = []

    // MARK: Set Initial Selected Media Types
    func setInitialSelectedMediaTypes(request: SearchForm.SelectMediaTypes.Request) {
        selectedMediaTypes = [.Movie]
        presenter?.displaySelectedMediaTypes(response: SearchForm.SelectMediaTypes.Response(selectedMediaTypes: [.Movie]))
    }

    func search(request: SearchForm.Search.Request) {
        guard let searchTerm = request.searchTerm, !searchTerm.isEmpty else {
            presenter?.showInfoAlert(response: SearchForm.Search.Response.Error(title: "Info", message: "Please type in the search term"))
            return
        }

        guard !request.mediaTypes.isEmpty else {
            presenter?.showInfoAlert(response: SearchForm.Search.Response.Error(title: "Info", message: "Please specify the media types to be searched"))
            return
        }

        presenter?.showLoadingIndicator()
        worker = SearchFormWorker()
        worker?.fetchResults(term: searchTerm, mediaTypes: request.mediaTypes, completion: {
            let response = SearchForm.Search.Response()
            self.presenter?.hideLoadingIndicator()
            self.presenter?.showResultsView(response: response)
        })
    }
}
