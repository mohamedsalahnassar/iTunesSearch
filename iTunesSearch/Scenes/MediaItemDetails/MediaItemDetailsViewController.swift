//
//  MediaItemDetailsViewController.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit
import AVKit

protocol MediaItemDetailsDisplayLogic: class {
    func displayItemDetails(viewModel: MediaItemDetails.displayMediaItem.ViewModel)
}

class MediaItemDetailsViewController: UIViewController, MediaItemDetailsDisplayLogic {
    var interactor: MediaItemDetailsBusinessLogic?
    var router: (NSObjectProtocol & MediaItemDetailsRoutingLogic & MediaItemDetailsDataPassing)?

    // MARK: Object lifecycle
    init(itunesMedia: ItunesMedia) {
        super.init(nibName: nil, bundle: nil)
        setup(itunesMedia: itunesMedia)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    private func setup(itunesMedia: ItunesMedia) {
        let viewController = self
        let interactor = MediaItemDetailsInteractor(itunesMedia: itunesMedia)
        let presenter = MediaItemDetailsPresenter()
        let router = MediaItemDetailsRouter()
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
        getItemDetails()
    }

    private func setupUI() {

    }

    // MARK: Display Media Item
    @IBOutlet private var itemTitle: UILabel!
    @IBOutlet private var itemSubtitle: UILabel!
    @IBOutlet private var longDescription: UILabel!
    @IBOutlet private var posterImage: UIImageView!
    @IBOutlet private var backgroundImage: UIImageView!
    @IBOutlet private var playPreviewButton: UIButton!

    @IBAction func didTapPlayPreviewVideo(_ sender: UIButton) {
        guard let previewLink = router?.dataStore?.itunesMedia.previewUrl else { return }
        router?.presentVideoPlayer(using: previewLink)
    }

    func getItemDetails() {
        interactor?.getItemDetails()
    }

    func displayItemDetails(viewModel: MediaItemDetails.displayMediaItem.ViewModel) {
        self.itemTitle.text = viewModel.title
        self.itemSubtitle.text = viewModel.subtitle
        self.longDescription.text = viewModel.longDescription
        self.posterImage.load(url: viewModel.image, placeholder: UIImage(named: "No-Image-Placeholder"))
        self.backgroundImage.load(url: viewModel.image, placeholder: UIImage(named: "No-Image-Placeholder"))
        playPreviewButton.isHidden = viewModel.previewURL == nil
    }
}
