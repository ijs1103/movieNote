//
//  MovieListPresenterTests.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import XCTest
@testable import movieNote

final class MovieListPresenterTests: XCTestCase {
    var sut: MovieListPresenter!
    var viewController: MockMovieListViewController!
    var coreDataManager: MockCoreDataManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieListViewController()
        coreDataManager = MockCoreDataManager()
        sut = MovieListPresenter(viewController: viewController, coreDataManager: coreDataManager)
    }
    override func tearDown() {
        sut = nil
        coreDataManager = nil
        viewController = nil
        
        super.tearDown()
    }
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }

    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()

        XCTAssertTrue(coreDataManager.isCalledGetMovieNotesFromeCoreData)
        XCTAssertTrue(viewController.isCalledReloadCollectionView)
        XCTAssertTrue(viewController.isCalledDarkModeCheck)
    }
    
    func test_didTapLeftBarButtonItem이_요청되면() {
        sut.didTapLeftBarButtonItem()
        
        XCTAssertTrue(viewController.isCalledPushToSettingsViewController)
    }
    
    func test_didTapRightBarButtonItem이_요청되면() {
        sut.didTapRightBarButtonItem()
        
        XCTAssertTrue(viewController.isCalledPushToMovieSearchViewController)
    }
}


