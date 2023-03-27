//
//  MockFontStyleViewController.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import Foundation
@testable import movieNote

final class MockFontStyleViewController: FontStyleProtocol {
    
    var isCalledSetupViews = false
    var isCalledDarkModeCheck = false
    var isCalledSetUIFont = false

    func setupViews() {
        isCalledSetupViews = true
    }
    
    func darkModeCheck() {
        isCalledDarkModeCheck = true
    }
    
    func setUIFont() {
        isCalledSetUIFont = true
    }
}
