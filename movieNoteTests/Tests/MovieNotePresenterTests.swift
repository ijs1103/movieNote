//
//  MovieNotePresenterTests.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import XCTest
@testable import movieNote

final class MovieNotePresenterTests: XCTestCase {
    var sut: MovieNotePresenter!
    var viewController: MockMovieNoteViewController!
    var movieNote: MovieNoteData?
    var coreDataManager: MockCoreDataManager!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockMovieNoteViewController()
        movieNote = MovieNoteData()
        coreDataManager = MockCoreDataManager()
        sut = MovieNotePresenter(viewController: viewController, movieNote: movieNote!, coreDataManager: coreDataManager)
    }
    override func tearDown() {
        sut = nil
        coreDataManager = nil
        movieNote = nil
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

        XCTAssertTrue(viewController.isCalledDarkModeCheck)
    }
    
    func test_didTapLeftBarButton이_요청되면() {
        sut.didTapLeftBarButton(contentsTextView: "")
        
        XCTAssertTrue(coreDataManager.isCalledUpdateMovieNote)
    }
    
    func test_didTapRightBarButton이_요청되면() {
        sut.didTapRightBarButton()
        
        XCTAssertTrue(viewController.isCalledMessageAlert)
    }
}
