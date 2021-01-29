//
//  MediaItemsViewController.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

protocol MediaItemsDisplayLogic: class {
    func displayMediaItems(viewModel: MediaItems.getMediaItems.ViewModel)
}

class MediaItemsViewController: UIViewController, MediaItemsDisplayLogic {
    enum CollectionViewLayoutType {
        case list, grid
    }

    // MARK: Constants
    private let gridCellsCountPerRow: Int = 3
    private let gridCellsCountPerColumn: Int = 4
    private let spacingBetweenCells: CGFloat = 10
    private let listCellsCount: Int = 7

    private var collectionViewLayoutType: CollectionViewLayoutType = .grid
    var interactor: MediaItemsBusinessLogic?
    var router: (NSObjectProtocol & MediaItemsRoutingLogic & MediaItemsDataPassing)?

    // MARK: Object lifecycle
    init(itemsToDisplay: [(MediaTypeEntity, [ItunesMedia])]) {
        super.init(nibName: nil, bundle: nil)
        setup(itemsToDisplay: itemsToDisplay)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    private func setup(itemsToDisplay: [(MediaTypeEntity, [ItunesMedia])]) {
        let viewController = self
        let interactor = MediaItemsInteractor()
        interactor.mediaItems = itemsToDisplay
        let presenter = MediaItemsPresenter()
        let router = MediaItemsRouter()
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
        navigationController?.setNavigationBarHidden(false, animated: true)
        getMediaItems()
    }

    func setupUI() {
        setNavigationItemButton()
        collectionView.register(MediaItemGridCell.nib, forCellWithReuseIdentifier: MediaItemGridCell.reuseIdentifier)
        collectionView.register(MediaItemListCell.nib, forCellWithReuseIdentifier: MediaItemListCell.reuseIdentifier)
        collectionView.register(MediaSectionHeaderView.nib, forSupplementaryViewOfKind: "HeaderView", withReuseIdentifier: MediaSectionHeaderView.className)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    private func setNavigationItemButton() {
        switch collectionViewLayoutType {
        case .grid:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(setCollectionViewLayoutToList(_:)))
        case .list:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.grid.3x3"), style: .plain, target: self, action: #selector(setCollectionViewLayoutToGrid(_:)))
        }
    }

    @objc private func setCollectionViewLayoutToGrid(_ sender: UIBarButtonItem) {
        collectionViewLayoutType = .grid
        collectionView.reloadData()
        setNavigationItemButton()
    }

    @objc private func setCollectionViewLayoutToList(_ sender: UIBarButtonItem) {
        collectionViewLayoutType = .list
        collectionView.reloadData()
        setNavigationItemButton()
    }

    // MARK: Display Media Items
    private var displayedMediaItemsSections: [MediaItems.getMediaItems.ViewModel.MediaItemsSection] = []
    @IBOutlet weak var collectionView: UICollectionView!

    func getMediaItems() {
        interactor?.getMediaItems()
    }

    func displayMediaItems(viewModel: MediaItems.getMediaItems.ViewModel) {
        displayedMediaItemsSections = viewModel.mediaItemsSections
        collectionView.reloadData()
    }
}

extension MediaItemsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return displayedMediaItemsSections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedMediaItemsSections[section].mediaItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionViewLayoutType {
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaItemGridCell.reuseIdentifier, for: indexPath) as! MediaItemGridCell
            let title = displayedMediaItemsSections[indexPath.section].mediaItems[indexPath.item].title
            let imageURL = displayedMediaItemsSections[indexPath.section].mediaItems[indexPath.item].image
            cell.configureCell(title: title, imageURL: imageURL)
            return cell
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaItemListCell.reuseIdentifier, for: indexPath) as! MediaItemListCell
            let title = displayedMediaItemsSections[indexPath.section].mediaItems[indexPath.item].title
            let imageURL = displayedMediaItemsSections[indexPath.section].mediaItems[indexPath.item].image
            let subtitle = displayedMediaItemsSections[indexPath.section].mediaItems[indexPath.item].subtitle
            cell.configureCell(title: title, imageURL: imageURL, subtitle: subtitle)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "HeaderView", withReuseIdentifier: MediaSectionHeaderView.className, for: indexPath) as! MediaSectionHeaderView
        headerView.configureHeader(with: displayedMediaItemsSections[indexPath.section].title)
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToItemDetailsView(forItemAt: indexPath)
    }
}

extension MediaItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        var height: CGFloat

        switch self.collectionViewLayoutType {
        case .grid:
            width = (collectionView.frame.width - (spacingBetweenCells * CGFloat(gridCellsCountPerRow + 1))) / CGFloat(gridCellsCountPerRow)
            height = (collectionView.frame.height) / CGFloat(gridCellsCountPerColumn)
        case .list:
            width = (collectionView.frame.width - (spacingBetweenCells * 2))
            height = (collectionView.frame.height) / CGFloat(listCellsCount)
        }
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacingBetweenCells
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacingBetweenCells
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: spacingBetweenCells, bottom: spacingBetweenCells, right: spacingBetweenCells)
    }
}
