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

    func enableIQKeyboardManager() {
        // enable IQKeyboardManager to avoid keyboard in all views
        IQKeyboardManager.shared.enable = true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
