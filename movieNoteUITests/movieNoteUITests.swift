//
//  movieNoteUITests.swift
//  movieNoteUITests
//
//  Created by 이주상 on 2023/03/15.
//

import XCTest
@testable import movieNote

class MovieNoteUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        // 하나의 테스트 항목이 실패하면 테스트 종료
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }
    override func tearDown() {
        super.tearDown()

        app = nil
    }

    func test_navigationBar의_title이_영화노트로_설정되어있다() {
        let existNavigationBar = app.navigationBars["영화 노트"].exists
        XCTAssertTrue(existNavigationBar)
    }

    func test_rightBarButtonItem이_존재한다() {
        let rightBarButtonItem = app.navigationBars.buttons["rightBarButtonItem"].exists
        XCTAssertTrue(rightBarButtonItem)
    }
    func test_leftBarButtonItem이_존재한다() {
        let leftBarButtonItem = app.navigationBars.buttons["leftBarButtonItem"].exists
        XCTAssertTrue(leftBarButtonItem)
    }
    func test_영화감상문이_추가_되어있으면 () {
        let existingCell = app.collectionViews
            .cells
            .containing(.image, identifier: nil)
            .element
            .exists

        XCTAssertTrue(existingCell, "영화 포스터가 존재한다")
    }
    func test_영화감상문이_추가_되어있지않으면 () {
        let existingCell = app.collectionViews
            .cells
            .containing(.image, identifier: nil)
            .element
            .exists

        XCTAssertFalse(existingCell, "영화 포스터가 존재하지 않는다")
    }
}
