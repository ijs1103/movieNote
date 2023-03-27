//
//  FontStylePresenterTests.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import XCTest
@testable import movieNote

final class FontStylePresenterTests: XCTestCase {
    var sut: FontStylePresenter!
    var viewController: MockFontStyleViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockFontStyleViewController()
        sut = FontStylePresenter(viewController: viewController)
    }
    override func tearDown() {
        sut = nil
        viewController = nil
        
        super.tearDown()
    }
    func test_viewDidLoad가_요청되면() {
        sut.viewDidLoad()

        XCTAssertTrue(viewController.isCalledSetupViews)
    }

    func test_viewWillAppear가_요청되면() {
        sut.viewWillAppear()

        XCTAssertTrue(viewController.isCalledDarkModeCheck)
        XCTAssertTrue(viewController.isCalledSetUIFont)
    }
}
