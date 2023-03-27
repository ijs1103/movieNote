//
//  MockMovieNoteViewController.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import Foundation
@testable import movieNote

final class MockMovieNoteViewController: MovieNoteProtocol {
    var isCalledSetupNavigationBar = false
    var isCalledSetupViews = false
    var isCalledDarkModeCheck = false
    var isCalledPushToMovieListViewController = false
    var isCalledMessageAlert = false
    var isCalledDidTapShareButton = false
    var isCalledUpdateMovieNote = false
    
    func setupNavigationBar() {
        isCalledSetupNavigationBar = true
    }
    
    func setupViews() {
        isCalledSetupViews = true
    }
    
    func darkModeCheck() {
        isCalledDarkModeCheck = true
    }
    
    func pushToMovieListViewController() {
        isCalledPushToMovieListViewController = true
    }
    
    func messageAlert(message: String, completion: @escaping (Bool) -> Void) {
        isCalledMessageAlert = true
    }
    
    func didTapShareButton() {
        isCalledDidTapShareButton = true
    }
    
    func updateMovieNote(contents: String) {
        isCalledUpdateMovieNote = true
    }
}
