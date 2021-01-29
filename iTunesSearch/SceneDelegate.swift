//
//  SceneDelegate.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 27/01/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // swiftlint:disable line_length
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // swiftlint:disable unused_optional_binding
        guard let windowScene = (scene as? UIWindowScene) else { return }
        initializeMainWindow(for: windowScene)
    }

    private func initializeMainWindow(for windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = instantiateNavigationAndMainView()

        self.window = window
        window.makeKeyAndVisible()
    }

    private func instantiateNavigationAndMainView() -> UINavigationController {
        let searchFormView = SearchFormViewController()
        return UINavigationController(rootViewController: searchFormView)
    }
}
