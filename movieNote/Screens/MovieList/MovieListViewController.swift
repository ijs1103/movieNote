//
//  MovieListViewController.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/16.
//
import SnapKit
import UIKit

final class MovieListViewController: UIViewController {
    
    private lazy var presenter = MovieListPresenter(viewController: self)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = presenter
        collectionView.dataSource = presenter
        collectionView.register(
            MovieListCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier
        )

        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
  
}

extension MovieListViewController: MovieListProtocol {
    
    func darkModeCheck() {
        appearanceCheck(self)
    }
    
    func setupNavigationBar() {
        navigationItem.title = "영화 노트"
        let image = UIImage(systemName: "slider.vertical.3")
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(didTapLeftBarButtonItem))
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapRightBarButtonItem))
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func pushToMovieSearchViewController() {
        let movieSearchViewController = MovieSearchViewController()
        navigationController?.pushViewController(movieSearchViewController, animated: true)
    }
    
    func pushToSettingsViewController() {
        let settingsViewController = SettingsViewController()
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func pushToMovieNoteViewController(with movieNote: MovieNoteData) {
        let movieNoteViewController = MovieNoteViewController(movieNote: movieNote)
        navigationController?.pushViewController(movieNoteViewController, animated: true)
    }
    
    func setUIFont() {
        let uiFont = FontManager.getFontStyle().uiFont
        navigationController?.navigationBar.titleTextAttributes = [.font: uiFont]
    }
}

private extension MovieListViewController {
    @objc func didTapLeftBarButtonItem() {
        presenter.didTapLeftBarButtonItem()
    }
    @objc func didTapRightBarButtonItem() {
        presenter.didTapRightBarButtonItem()
    }
}
