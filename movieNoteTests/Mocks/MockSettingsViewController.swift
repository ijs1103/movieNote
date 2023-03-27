//
//  MockSettingsViewController.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//
import Foundation
@testable import movieNote

final class MockSettingsViewController: SettingsProtocol {
    
    var isCalledSetupNavigationBar = false
    var isCalledSetupViews = false
    var isCalledDarkModeCheck = false
    var isCalledPushToThemeViewController = false
    var isCalledPushToFontStyleViewController = false
    var isCalledPushToLicenseViewController = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func darkModeCheck() {
        isCalledDarkModeCheck = true
    }
    func pushToThemeViewController() {
        isCalledPushToThemeViewController = true
    }
    
    func pushToFontStyleViewController() {
        isCalledPushToFontStyleViewController = true
    }
    
    func pushToLicenseViewController() {
        isCalledPushToLicenseViewController = true
    }
}
