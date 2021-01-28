//
//  SearchFormRouter.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

protocol SearchFormRoutingLogic {
    func navigateToSelectMediaTypesView(didUpdateSelectedMediaTypes: @escaping ([MediaType]) -> Void)
    func navigateToSearchResultsView(segue: UIStoryboardSegue?)
}

protocol SearchFormDataPassing {
    var dataStore: SearchFormDataStore? { get }
}

class SearchFormRouter: NSObject, SearchFormRoutingLogic, SearchFormDataPassing {
    weak var viewController: SearchFormViewController?
    var dataStore: SearchFormDataStore?

    // MARK: Routing
    func navigateToSelectMediaTypesView(didUpdateSelectedMediaTypes: @escaping ([MediaType]) -> Void) {
        let options = MediaType.allCases.map {
            GenericMultiSelectorVC<MediaType>.Option(
                id: $0,
                isSelected: dataStore?.selectedMediaTypes.contains($0) ?? false
            )
        }

        let mediaTypesPickerVC = GenericMultiSelectorVC(options: options) { [weak self] (picker, options) in
            guard let self = self else { return }
            self.dataStore?.selectedMediaTypes = options.filter({$0.isSelected}).map({$0.id})
            didUpdateSelectedMediaTypes(self.dataStore?.selectedMediaTypes ?? [])
            picker.dismiss(animated: true)
        }
        mediaTypesPickerVC.title = "Select Media Types"
        let navigationController = UINavigationController(rootViewController: mediaTypesPickerVC)
        navigationController.navigationBar.prefersLargeTitles = false
        viewController?.present(navigationController, animated: true, completion: nil)
    }

    func navigateToSearchResultsView(segue: UIStoryboardSegue?) {

    }

}
