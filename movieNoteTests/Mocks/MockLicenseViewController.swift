//
//  MockLicenseViewController.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import Foundation
@testable import movieNote

final class MockLicenseViewController: LicenseProtocol {
    
    var isCalledSetupViews = false
    var isCalledDarkModeCheck = false

    func setupViews() {
        isCalledSetupViews = true
    }
    
    func darkModeCheck() {
        isCalledDarkModeCheck = true
    }

}
