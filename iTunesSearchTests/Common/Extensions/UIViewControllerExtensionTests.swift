//
//  UIViewControllerExtensionTests.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest
import MBProgressHUD

class UIViewControllerExtensionTests: XCTestCase {
    // MARK: - Subject under test
    var sut: UIViewController!
    var window: UIWindow!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup
    func setupViewController() {
        sut = UIViewController()
        sut.loadView()
        sut.viewDidLoad()
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Tests
    func testShouldShowAndHideActivityIndicator() {
        // Given

        // When
        loadView()
        sut.showActivityIndicator()

        // Then
        DispatchQueue.main.async {
            XCTAssertNotNil(MBProgressHUD.forView(self.sut.view))
        }

        // When
        sut.hideActivityIndicator()

        // Then
        DispatchQueue.main.async {
            XCTAssertNil(MBProgressHUD.forView(self.sut.view))
        }
    }
}
