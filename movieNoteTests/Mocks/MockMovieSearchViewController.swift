//
//  MockMovieSearchViewController.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import Foundation
@testable import movieNote

final class MockMovieSearchViewController: MovieSearchProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupSearchBar = false
    var isCalledSetupViews = false
    var isCalledDarkModeCheck = false
    var isCalledToggleSearchLabel = false
    var isCalledReloadTableView = false
    var isCalledPushToMovieListViewController = false
    var isCalledPushToImagePickerViewController = false
    var isCalledMessageAlert = false
    var isCalledMovieTitleAlert = false
    var isCalledDuplicateAlert = false

    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupSearchBar() {
        isCalledSetupSearchBar = true
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func darkModeCheck() {
        isCalledDarkModeCheck = true
    }
    
    func toggleSearchLabel(isHidden: Bool) {
        isCalledToggleSearchLabel = true
    }
    
    func reloadTableView(isHidden: Bool) {
        isCalledReloadTableView = true
    }
    
    func pushToMovieListViewController() {
        isCalledPushToMovieListViewController = true
    }
    
    func pushToImagePickerViewController() {
        isCalledPushToImagePickerViewController = true
    }
    
    func messageAlert(message: String, completion: @escaping (Bool) -> Void) {
        isCalledMessageAlert = true
    }
    
    func movieTitleAlert(completion: @escaping (String?, Bool) -> Void) {
        isCalledMovieTitleAlert = true
    }
    
    func duplicateAlert() {
        isCalledDuplicateAlert = true
    }
}
