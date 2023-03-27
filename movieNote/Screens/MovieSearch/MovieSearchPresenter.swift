//
//  MovieSearchPresenter.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/17.
//

import UIKit
import Kingfisher

protocol MovieSearchProtocol: AnyObject {
    func setupNavigationBar()
    func setupSearchBar()
    func setupViews()
    func darkModeCheck()
    func toggleSearchLabel(isHidden: Bool)
    func reloadTableView(isHidden: Bool)
    func pushToMovieListViewController()
    func pushToImagePickerViewController()
    func messageAlert(message: String, completion: @escaping (Bool) -> Void)
    func movieTitleAlert(completion: @escaping (String?, Bool) -> Void)
    func duplicateAlert()
}

final class MovieSearchPresenter: NSObject {
    private weak var viewController: MovieSearchProtocol?
    
    private let coreDataManager: CoreDataManagerProtocol
    
    private let netWorkManager: NetworkManagerProtocol
    
    private var searchedMovie: [Movie] = []
    
    init(viewController: MovieSearchProtocol, netWorkManager: NetworkManagerProtocol = NetworkManager(),
         coreDataManager: CoreDataManagerProtocol = CoreDataManager.shared
    ) {
        self.viewController = viewController
        self.netWorkManager = netWorkManager
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupSearchBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        viewController?.darkModeCheck()
    }
    
    func didTapAlbumButtonItem() {
        viewController?.pushToImagePickerViewController()
    }
    
}

extension MovieSearchPresenter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.reloadTableView(isHidden: false)
        viewController?.toggleSearchLabel(isHidden: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchedMovie = []
        viewController?.reloadTableView(isHidden: true)
        viewController?.toggleSearchLabel(isHidden: false)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        netWorkManager.fetchMovie(from: searchText) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(result):
                self.searchedMovie = result
                self.viewController?.reloadTableView(isHidden: false)
            case let .failure(error):
                debugPrint("fetch failed. error: \(error)")
            }
        }
    }
}

extension MovieSearchPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = searchedMovie[indexPath.row]
        let message = "'\(movie.title.htmlToString)'를(을) 추가 하시겠습니까?"
        viewController?.messageAlert(message: message) { [weak self] okButtonTapped in
            guard let self = self else { return }
            if okButtonTapped {
                if self.coreDataManager.isSavedMovieNote(with: movie.title.htmlToString) {
                    self.viewController?.duplicateAlert()
                } else {
                    // 즐겨찾기 추가
                    self.coreDataManager.setMovieNote(with: movie, contents: "")
                    self.viewController?.pushToMovieListViewController()
                }
            }
        }
    }
}

extension MovieSearchPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchedMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.identifier, for: indexPath) as? MovieSearchTableViewCell
        let movie = searchedMovie[indexPath.item]
        cell?.update(movie)
        cell?.selectionStyle = .none
        
        return cell ?? UITableViewCell()
    }
}

extension MovieSearchPresenter: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        var selectImage: UIImage?
            
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectImage = originalImage
        }
        
        picker.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.viewController?.movieTitleAlert { title, okTapped in
                if !okTapped { return }
                let movie = Movie(title!, selectImage!)
                self.coreDataManager.setMovieNote(with: movie, contents: "")
                self.viewController?.pushToMovieListViewController()
            }
        }
        
    }
}
