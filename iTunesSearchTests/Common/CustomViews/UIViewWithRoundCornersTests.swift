//
//  UIViewWithRoundCornersTests.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class UIViewWithRoundCornersTests: XCTestCase {
    // MARK: Subject Under Test
    var sut: UIViewWithRoundCorners!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = UIViewWithRoundCorners()
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

    func testGetterCornerRadiusWithoutMasksToBounds() {
        // Given
        sut.layer.cornerRadius = 10.0

        // When

        // Then
        XCTAssert(sut.cornerRadiusWithoutMasksToBounds == 10)
    }

    func testSetterCornerRadiusWithoutMasksToBounds() {
        // Given
        sut.cornerRadiusWithoutMasksToBounds = 10.0

        // When

        // Then
        XCTAssert(sut.layer.cornerRadius == 10)
    }

    func testGetterBorderWidth() {
        // Given
        sut.layer.borderWidth = 10.0

        // When

        // Then
        XCTAssert(sut.borderWidth == 10)
    }

    func testSetterBorderWidth() {
        // Given
        sut.borderWidth = 10.0

        // When

        // Then
        XCTAssert(sut.layer.borderWidth == 10)
    }

    func testGetterBorderColor() {
        // Given
        sut.layer.borderColor = UIColor.white.cgColor

        // When

        // Then
        XCTAssert(sut.borderColor == UIColor.white)
    }

    func testSetterBorderColor() {
        // Given
        sut.borderColor = UIColor.white

        // When

        // Then
        XCTAssert(sut.layer.borderColor == UIColor.white.cgColor)
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
