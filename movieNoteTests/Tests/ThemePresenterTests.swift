//
//  ThemePresenterTests.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import XCTest
@testable import movieNote

final class ThemePresenterTests: XCTestCase {
    var sut: ThemePresenter!
    var viewController: MockThemeViewController!
    
    override func setUp() {
        super.setUp()
        
        viewController = MockThemeViewController()
        sut = ThemePresenter(viewController: viewController)
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
    }
    
    func test_didTapSwitch가_요청되면() {
        let uiSwitch = UISwitch()
        sut.didTapSwitch(sender: uiSwitch)
        XCTAssertTrue(viewController.isCalledToggleDarkMode)
    }
}
