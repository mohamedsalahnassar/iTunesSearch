//
//  UIButtonWithRoundCornersTests.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class UIButtonWithRoundCornersTests: XCTestCase {
    // MARK: Subject Under Test
    var sut: UIButtonWithRoundCorners!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = UIButtonWithRoundCorners()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: Test cases
    func testGetterCornerRadius() {
        // Given
        sut.layer.cornerRadius = 10.0

        // When

        // Then
        XCTAssert(sut.cornerRadius == 10)
    }

    func testGetterBorderWidth() {
        // Given
        sut.layer.borderWidth = 10.0

        // When

        // Then
        XCTAssert(sut.borderWidth == 10)
    }

    func testGetterBorderColor() {
        // Given
        sut.layer.borderColor = UIColor.white.cgColor

        // When

        // Then
        XCTAssert(sut.borderColor == UIColor.white)
    }

    func testGetterShadowRadius() {
        // Given
        sut.layer.shadowRadius = 10.0

        // When

        // Then
        XCTAssert(sut.shadowRadius == 10)
    }

    func testSetterShadowRadius() {
        // Given
        sut.shadowRadius = 10.0

        // When

        // Then
        XCTAssert(sut.layer.shadowRadius == 10)
    }

}
