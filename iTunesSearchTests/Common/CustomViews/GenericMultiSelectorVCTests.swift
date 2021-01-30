//
//  GenericMultiSelectorVCTests.swift
//  iTunesSearchTests
//
//  Created by Mohamed Nassar on 30/01/2021.
//  Copyright © 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class GenericMultiSelectorVCTests: XCTestCase {
    // MARK: - Subject under test
    var sut: GenericMultiSelectorVC<Int>!
    var window: UIWindow!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: - Test Doubles
    class UITableViewCellSpy: UITableViewCell {

    }

    // MARK: - Test setup
    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Tests
    func testInitializingFromCoderShouldGiveNil() {
        // Given
        sut = GenericMultiSelectorVC<Int>(coder: NSCoder())

        // When

        // Then
        XCTAssertNil(sut)
    }

    func testShouldReturnTheExpectedResults() {
        // Given
        let option1 = GenericMultiSelectorVC<Int>.Option(id: 1, isSelected: true)
        let option2 = GenericMultiSelectorVC<Int>.Option(id: 2, isSelected: false)

        var result: [GenericMultiSelectorVC<Int>.Option] = []

        sut = GenericMultiSelectorVC<Int>(options: [option1, option2]) { (_, modifiedOptions) in
            result = modifiedOptions
        }

        // When
        loadView()
        let firstOptionCell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        firstOptionCell?.select(firstOptionCell)
        let secondOptionCell = sut.tableView.cellForRow(at: IndexPath(row: 1, section: 0))
        secondOptionCell?.select(firstOptionCell)

        sut.didTapDoneButton()

        // Then
        XCTAssertTrue(!result.isEmpty)
        XCTAssertEqual(result[0].id, 1)
        XCTAssertEqual(result[1].id, 2)
    }

    func testTableViewShouldDequeueCell() {
        // Given
        let option1 = GenericMultiSelectorVC<Int>.Option(id: 1, isSelected: true)
        let option2 = GenericMultiSelectorVC<Int>.Option(id: 2, isSelected: false)

        sut = GenericMultiSelectorVC<Int>(options: [option1, option2]) { (_, _) in }

        // When
        loadView()
        let firstOptionCell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        let secondOptionCell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 1, section: 0))

        sut.didTapDoneButton()

        // Then
        XCTAssertEqual(firstOptionCell.textLabel?.text, "\(option1.id)")
        XCTAssertEqual(secondOptionCell.textLabel?.text, "\(option2.id)")
    }
}
