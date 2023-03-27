//
//  MockMovieListViewController.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import Foundation
@testable import movieNote

final class MockMovieListViewController: MovieListProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupViews = false
    var isCalledDarkModeCheck = false
    var isCalledPushToMovieSearchViewController = false
    var isCalledPushToSettingsViewController = false
    var isCalledPushToMovieNoteViewController = false
    var isCalledReloadCollectionView = false
    var isCalledSetUIFont = false

    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    func setupViews() {
        isCalledSetupViews = true
    }
    func darkModeCheck() {
        isCalledDarkModeCheck = true
    }
    func pushToMovieSearchViewController() {
        isCalledPushToMovieSearchViewController = true
    }
    func pushToSettingsViewController() {
        isCalledPushToSettingsViewController = true
    }
    func pushToMovieNoteViewController(with movieNote: MovieNoteData) {
        isCalledPushToMovieNoteViewController = true
    }
    func reloadCollectionView() {
        isCalledReloadCollectionView = true
    }
    func setUIFont() {
        isCalledSetUIFont = true
    }
}
