//
//  MovieSearchPresenterTests.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import XCTest
@testable import movieNote

final class MovieSearchPresenterTests: XCTestCase {
    var sut: MovieSearchPresenter!
    var viewController: MockMovieSearchViewController!
    var coreDataManager: MockCoreDataManager!
    var networkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieSearchViewController()
        coreDataManager = MockCoreDataManager()
        networkManager = MockNetworkManager()
        sut = MovieSearchPresenter(viewController: viewController, networkManager: networkManager, coreDataManager: coreDataManager)

    }
    override func tearDown() {
        sut = nil
        networkManager = nil
        coreDataManager = nil
        viewController = nil
        
        super.tearDown()
    }
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetupNavigationBar)
        XCTAssertTrue(viewController.isCalledSetupSearchBar)
        XCTAssertTrue(viewController.isCalledSetupViews)
    }

    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()

        XCTAssertTrue(viewController.isCalledDarkModeCheck)
    }
    
    func test_didTapAlbumButtonItem이_요청되면() {
        sut.didTapAlbumButtonItem()
        
        XCTAssertTrue(viewController.isCalledPushToImagePickerViewController)
    }

}
