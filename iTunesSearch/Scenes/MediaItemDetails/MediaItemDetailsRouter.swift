//
//  MediaItemDetailsRouter.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit
import AVKit

@objc protocol MediaItemDetailsRoutingLogic {
    func presentVideoPlayer(using url: URL)
}

protocol MediaItemDetailsDataPassing {
    var dataStore: MediaItemDetailsDataStore? { get }
}

class MediaItemDetailsRouter: NSObject, MediaItemDetailsRoutingLogic, MediaItemDetailsDataPassing {
    weak var viewController: MediaItemDetailsViewController?
    var dataStore: MediaItemDetailsDataStore?

    func presentVideoPlayer(using url: URL) {
        let player = AVPlayer(url: url)
        let playerVC = AVPlayerViewController()
        playerVC.entersFullScreenWhenPlaybackBegins = true
        playerVC.player = player
        viewController?.present(playerVC, animated: true, completion: {
            player.play()
        })
    }
}
