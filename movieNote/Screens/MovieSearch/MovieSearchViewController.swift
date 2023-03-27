//
//  MovieSearchViewController.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/17.
//
import SnapKit
import UIKit

final class MovieSearchViewController: UIViewController {
    
    private lazy var presenter = MovieSearchPresenter(viewController: self)
    
    private let searchController = UISearchController()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.delegate = presenter
        tableView.register(MovieSearchTableViewCell.self, forCellReuseIdentifier: MovieSearchTableViewCell.identifier)

        return tableView
    }()
    
    private let searchLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.textColor = .secondaryLabel
        uiLabel.text = "제목 혹은 작가로 검색하세요"
        
        return uiLabel
    }()
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = presenter
        
        return imagePickerController
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

extension MovieSearchViewController: MovieSearchProtocol {
    
    func darkModeCheck() {
        appearanceCheck(self)
    }

    func duplicateAlert() {
        let alert = UIAlertController(title: "알림", message: "이미 작성한 영화입니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func messageAlert(message: String, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            completion(true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            completion(false)
        }
        [ ok, cancel ].forEach {
            alert.addAction($0)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func movieTitleAlert(completion: @escaping (String?, Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: "영화 제목을 입력하세요.", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "영화 제목"
        }
        var savedText: String? = ""
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            savedText = alert.textFields?[0].text
            completion(savedText, true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            completion(nil, false)
        }
        [ok, cancel].forEach {
            alert.addAction($0)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupNavigationBar() {
        navigationItem.title = "영화 추가"
        let rightBarButtonItem = UIBarButtonItem(title: "album", style: .plain, target: self, action: #selector(didTapAlbumButtonItem))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        let uiFont = FontManager.getFontStyle().uiFont 
        navigationController?.navigationBar.titleTextAttributes = [.font: uiFont]
    }
    
    func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = presenter
        searchController.searchBar.searchTextField.backgroundColor = .white
        navigationItem.searchController = searchController
        // searchBar 안보이는 에러 해결
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        [tableView, searchLabel].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        tableView.isHidden = true
    }
    
    func toggleSearchLabel(isHidden: Bool) {
        searchLabel.isHidden = isHidden
    }
    
    func reloadTableView(isHidden: Bool) {
        tableView.isHidden = isHidden
        tableView.reloadData()
    }
    
    func pushToMovieListViewController() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func pushToImagePickerViewController() {
        present(imagePickerController, animated: true)
    }
}

private extension MovieSearchViewController {
    @objc func didTapAlbumButtonItem() {
        presenter.didTapAlbumButtonItem()
    }
}
