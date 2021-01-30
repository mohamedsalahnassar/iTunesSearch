//
//  SearchFormViewController.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit
import SCLAlertView

protocol SearchFormDisplayLogic: class {
    func displaySelectedMediaTypes(viewModel: SearchForm.SelectMediaTypes.ViewModel)
    func showSearchResultsView(fetchedData: [(MediaTypeEntity, [ItunesMedia])])
    func showErrorAlert(title: String, message: String)
    func showInfoAlert(title: String, message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

class SearchFormViewController: UIViewController, SearchFormDisplayLogic {
    var interactor: SearchFormBusinessLogic?
    var router: (NSObjectProtocol & SearchFormRoutingLogic & SearchFormDataPassing)?

    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = SearchFormInteractor()
        let presenter = SearchFormPresenter()
        let router = SearchFormRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    private func setupUI() {
        selectedMediaTypeCollectionView.delegate = self
        selectedMediaTypeCollectionView.dataSource = self
        selectedMediaTypeCollectionView.register(MediaTypeCell.nib, forCellWithReuseIdentifier: MediaTypeCell.reuseIdentifier)
        searchKeywordsTextField.delegate = self
    }

    // MARK: Search iTunes
    @IBOutlet weak var searchKeywordsTextField: UITextField!

    @IBAction func didTapSubmitButton(_ sender: Any) {
        interactor?.search(request: SearchForm.Search.Request(searchTerm: searchKeywordsTextField.text, mediaTypes: displayedMediaTypes))
    }

    // MARK: Select Media Types Entities
    @IBOutlet weak var selectedMediaTypeCollectionView: UICollectionView!

    @IBAction func didTapSelectMediaTypesButton(_ sender: Any) {
        router?.navigateToSelectMediaTypesView(didUpdateSelectedMediaTypes: { [weak self] (selectedMediaTypes) in
            guard let self = self else { return }
            self.displayedMediaTypes = selectedMediaTypes
            self.selectedMediaTypeCollectionView.reloadData()
        })
    }

    // MARK: Display Selected Media Types Entities
    var displayedMediaTypes: [MediaTypeEntity] = []

    func displaySelectedMediaTypes(viewModel: SearchForm.SelectMediaTypes.ViewModel) {
        displayedMediaTypes = viewModel.selectedMediaTypes
        selectedMediaTypeCollectionView.reloadData()
    }

    // MARK: - Show Search Results View
    func showSearchResultsView(fetchedData: [(MediaTypeEntity, [ItunesMedia])]) {
        router?.routeToSearchResultsView(fetchedData: fetchedData)
    }

    // MARK: Error handling
    func showInfoAlert(title: String, message: String) {
        SCLAlertView().showInfo(title, subTitle: message, closeButtonTitle: "Ok", animationStyle: .topToBottom)
    }

    func showErrorAlert(title: String, message: String) {
        SCLAlertView().showError(title, subTitle: message, closeButtonTitle: "Ok", animationStyle: .topToBottom)
    }

    // MARK: Loading Indicator
    func showLoadingIndicator() {
        showActivityIndicator()
    }

    func hideLoadingIndicator() {
        hideActivityIndicator()
    }

}

extension SearchFormViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMediaTypes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaTypeCell.reuseIdentifier, for: indexPath) as! MediaTypeCell
        cell.title.text = displayedMediaTypes[indexPath.row].description
        return cell
    }

}

extension SearchFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        didTapSubmitButton(self)
        return true
    }
}
