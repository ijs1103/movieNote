//
//  MovieListPresenter.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/16.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setupNavigationBar()
    func setupViews()
    func darkModeCheck()
    func pushToMovieSearchViewController()
    func pushToSettingsViewController()
    func pushToMovieNoteViewController(with movieNote: MovieNoteData)
    func reloadCollectionView()
    func setUIFont()
}

final class MovieListPresenter: NSObject {
    private weak var viewController: MovieListProtocol?
    
    private let coreDataManager: CoreDataManagerProtocol
    
    private var movieNotes: [MovieNoteData] = []
    
    init(viewController: MovieListProtocol, coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.viewController = viewController
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupViews()
    }

    func viewWillAppear() {
        movieNotes = coreDataManager.getMovieNotesFromeCoreData()
        viewController?.reloadCollectionView()
        viewController?.darkModeCheck()
    }
    
    func didTapLeftBarButtonItem() {
        viewController?.pushToSettingsViewController()
    }
    
    func didTapRightBarButtonItem() {
        viewController?.pushToMovieSearchViewController()
    }
    
}
extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 3 - 2.0
        return CGSize(width: width, height: width * 1.5)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieNote = movieNotes[indexPath.item]
        viewController?.pushToMovieNoteViewController(with: movieNote)
    }
}

extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell
        
        let movieNote = movieNotes[indexPath.item]
        cell?.update(movieNote)
        
        return cell ?? UICollectionViewCell()
    }
}
