//
//  MediaItemDetailsRouter.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

import UIKit

@objc protocol MediaItemDetailsRoutingLogic {
    // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol MediaItemDetailsDataPassing {
    var dataStore: MediaItemDetailsDataStore? { get }
}

class MediaItemDetailsRouter: NSObject, MediaItemDetailsRoutingLogic, MediaItemDetailsDataPassing {
    weak var viewController: MediaItemDetailsViewController?
    var dataStore: MediaItemDetailsDataStore?
}
