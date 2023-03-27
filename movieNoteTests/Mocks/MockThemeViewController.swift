//
//  MockThemeViewController.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import UIKit
@testable import movieNote

final class MockThemeViewController: ThemeProtocol {
    
    var isCalledSetupViews = false
    var isCalledDarkModeCheck = false
    var isCalledToggleDarkMode = false
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func darkModeCheck() {
        isCalledDarkModeCheck = true
    }
    
    func toggleDarkMode(sender: UISwitch) {
        isCalledToggleDarkMode = true
    }
}
