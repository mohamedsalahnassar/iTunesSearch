//
//  SearchFormPresenter.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

protocol SearchFormPresentationLogic {
    func displaySelectedMediaTypes(response: SearchForm.SelectMediaTypes.Response)
    func showResultsView(response: SearchForm.Search.Response)
    func showInfoAlert(response: SearchForm.Search.Response.Error)
    func showErrorAlert(response: SearchForm.Search.Response.Error)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

class SearchFormPresenter: SearchFormPresentationLogic {
    weak var viewController: SearchFormDisplayLogic?

    // MARK: Display Selected Media Types
    func displaySelectedMediaTypes(response: SearchForm.SelectMediaTypes.Response) {
        let viewModel = SearchForm.SelectMediaTypes.ViewModel(selectedMediaTypes: response.selectedMediaTypes.map(\.rawValue))
        viewController?.displaySelectedMediaTypes(viewModel: viewModel)
    }

    func showResultsView(response: SearchForm.Search.Response) {
        print(#file, #function)
    }

    func showInfoAlert(response: SearchForm.Search.Response.Error) {
        viewController?.showInfoAlert(title: response.title, message: response.message)
    }
    func showErrorAlert(response: SearchForm.Search.Response.Error) {
        viewController?.showErrorAlert(title: response.title, message: response.message)
    }

    func showLoadingIndicator() {
        viewController?.showLoadingIndicator()
    }

    func hideLoadingIndicator() {
        viewController?.hideLoadingIndicator()
    }

}
