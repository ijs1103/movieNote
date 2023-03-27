//
//  MovieNotePresenter.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/20.
//

import Foundation

protocol MovieNoteProtocol: AnyObject {
    func setupNavigationBar()
    func setupViews()
    func darkModeCheck()
    func pushToMovieListViewController()
    func messageAlert(message: String, completion: @escaping (Bool) -> Void)
    func didTapShareButton()
}

final class MovieNotePresenter: NSObject {
    
    private weak var viewController: MovieNoteProtocol?
    
    private var movieNote: MovieNoteData
    
    private let coreDataManager: CoreDataManagerProtocol
    
    init(viewController: MovieNoteProtocol,
         movieNote: MovieNoteData,
         coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.viewController = viewController
        self.movieNote = movieNote
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        viewController?.darkModeCheck()
    }
    
    func didTapLeftBarButton(contentsTextView contents: String) {
        movieNote.contents = contents
        coreDataManager.updateMovieNote(with: movieNote) {            self.viewController?.pushToMovieListViewController()
        }
    }
    
    func didTapRightBarButton() {
        let message = "정말로 삭제하시겠습니까?"
        self.viewController?.messageAlert(message: message) {
            [weak self] okButtonTapped in
            guard let self = self else { return }
            if okButtonTapped {
                self.coreDataManager.deleteMovieNote(with: self.movieNote) {
                    self.viewController?.pushToMovieListViewController()
                }
            }
        }
    }
}
