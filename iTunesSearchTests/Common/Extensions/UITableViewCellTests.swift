//
//  UITableViewCellTests.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest
import UIKit

class UITableViewCellTests: XCTestCase {
    // MARK: Subject Under Test
    class TestUITableViewCellCell: UITableViewCell {}

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test cases
    func testReuseIdentifierShouldReturnClassName() {
        XCTAssertEqual(TestUITableViewCellCell.reuseIdentifier, "TestUITableViewCellCell")
    }
}
