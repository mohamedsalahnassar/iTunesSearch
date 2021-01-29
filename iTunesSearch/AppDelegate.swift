//
//  AppDelegate.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // swiftlint:disable line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        enableIQKeyboardManager()
        return true
    }

    private func enableIQKeyboardManager() {
        // enable IQKeyboardManager to avoid keyboard in all views
        IQKeyboardManager.shared.enable = true
    }
}
