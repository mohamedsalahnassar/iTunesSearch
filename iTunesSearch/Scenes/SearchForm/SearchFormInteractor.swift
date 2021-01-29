//
//  SearchFormInteractor.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit
import Networking

protocol SearchFormBusinessLogic {
    func search(request: SearchForm.Search.Request)
}

protocol SearchFormDataStore {
    var selectedMediaTypes: [MediaTypeEntity] { get set }
}

class SearchFormInteractor: SearchFormBusinessLogic, SearchFormDataStore {
    var presenter: SearchFormPresentationLogic?
    var worker: SearchFormWorker?
    var selectedMediaTypes: [MediaTypeEntity] = []

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
        worker = SearchFormWorker(searchService: SearchAPIService())
        worker?.fetchResults(term: searchTerm, for: request.mediaTypes, completionHandler: { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                let response = SearchForm.Search.Response.Error(title: "error", message: error.localizedDescription)
                self.presenter?.hideLoadingIndicator()
                self.presenter?.showErrorAlert(response: response)
            case .success(let mediaResults):
                self.presenter?.hideLoadingIndicator()
                let response = SearchForm.Search.Response(itunesMediaItems: mediaResults)
                self.presenter?.showResultsView(response: response)
            }
        })
    }
}
