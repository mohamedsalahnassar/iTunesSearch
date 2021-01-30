//
//  SearchFormViewControllerTests.swift
//  iTunesSearch
//
//  Created by Mohamed Nassar on 29/01/2021.
//  Copyright (c) 2021 Nagarro. All rights reserved.
//

@testable import iTunesSearch
import XCTest

class SearchFormViewControllerTests: XCTestCase {
    // MARK: - Subject under test
    var sut: SearchFormViewController!
    var window: UIWindow!

    // MARK: - Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupSearchFormViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: - Test setup
    func setupSearchFormViewController() {
        sut = SearchFormViewController(nibName: nil, bundle: nil)
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: - Test doubles
    class SearchFormBusinessLogicSpy: SearchFormBusinessLogic {
        var invokedSearch = false
        var invokedSearchCount = 0
        var invokedSearchParameters: (request: SearchForm.Search.Request, Void)?
        var invokedSearchParametersList = [(request: SearchForm.Search.Request, Void)]()

        func search(request: SearchForm.Search.Request) {
            invokedSearch = true
            invokedSearchCount += 1
            invokedSearchParameters = (request, ())
            invokedSearchParametersList.append((request, ()))
        }
    }

    class CollectionViewSpy: UICollectionView {
        // MARK: Method call expectations
        var reloadDataCalled = false

        // MARK: Spied methods
        override func reloadData() {
            reloadDataCalled = true
        }
    }

    // MARK: - Tests
    func testShouldFetchOrdersWhenViewDidAppear() {
        // Given
        let searchFormBusinessLogicSpy = SearchFormBusinessLogicSpy()
        sut.interactor = searchFormBusinessLogicSpy
        loadView()

        // When
        sut.viewDidAppear(true)

        // Then
//        XCTAssert(searchFormBusinessLogicSpy.invokedSearch, "Should fetch orders right after the view appears")
    }

    func testShouldDisplaySelectedMediaTypes() {
        // Given
        let collectionViewSpy = CollectionViewSpy(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        sut.selectedMediaTypeCollectionView = collectionViewSpy

        // When
        let viewModel = SearchForm.SelectMediaTypes.ViewModel(selectedMediaTypes: [.album])
        sut.displaySelectedMediaTypes(viewModel: viewModel)

        // Then
        XCTAssert(collectionViewSpy.reloadDataCalled)
    }

    func testNumberOfSectionsInCollectionViewShouldAlwaysBeOne() {
        // Given
        let collectionViewSpy = CollectionViewSpy(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewSpy.delegate = sut
        collectionViewSpy.dataSource = sut
        sut.selectedMediaTypeCollectionView = collectionViewSpy

        // When
        loadView()

        // Then
        let numberOfSections = self.sut.numberOfSections(in: collectionViewSpy)
        XCTAssertEqual(numberOfSections, 1)
    }

    func testNumberOfItemsInAnySectionInCollectionViewShouldAlwaysBeOne() {
        // Given
        let collectionViewSpy = CollectionViewSpy(frame: CGRect(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
        collectionViewSpy.delegate = sut
        collectionViewSpy.dataSource = sut
        collectionViewSpy.register(MediaTypeCell.nib, forCellWithReuseIdentifier: MediaTypeCell.reuseIdentifier)
        sut.selectedMediaTypeCollectionView = collectionViewSpy

        // When
        loadView()
        let viewModel = SearchForm.SelectMediaTypes.ViewModel(selectedMediaTypes: MediaTypeEntity.allCases)
        sut.displaySelectedMediaTypes(viewModel: viewModel)

        // Then
        let numberOfItems = self.sut.collectionView(collectionViewSpy, numberOfItemsInSection: 0)
        XCTAssertEqual(numberOfItems, MediaTypeEntity.allCases.count)
    }
}
