//
//  MovieNoteViewController.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/20.
//

import SnapKit
import UIKit

final class MovieNoteViewController: UIViewController {
    
    private var presenter: MovieNotePresenter!
    
    private var movieNote: MovieNoteData!
    
    private var uiFont: UIFont {
        return FontManager.getFontStyle().uiFont
    }
    
    private lazy var createdAtLabel: UILabel = {
        let uiLabel = UILabel()
        uiLabel.text = movieNote.createdAt
        uiLabel.font = .systemFont(ofSize: 14.0)
        
        return uiLabel
    }()
    
    private lazy var contentsTextView: UITextView = {
        let textView = UITextView()
        let hasContents = (movieNote.contents != "")
        textView.textColor = hasContents ? .label : .tertiaryLabel
        textView.text = hasContents ? movieNote.contents : Constants.contentsTextViewPlaceholder
        textView.font = uiFont
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var shareButton: UIButton = {

        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "square.and.arrow.up")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 20.0
        configuration.title = "공유하기"
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.didTapShareButton()
        }))
        button.titleLabel?.font = uiFont
        
        return button
    }()
    
    init(movieNote: MovieNoteData) {
        super.init(nibName: nil, bundle: nil)
        presenter = MovieNotePresenter(viewController: self, movieNote: movieNote)
        self.movieNote = movieNote
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
}

extension MovieNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .tertiaryLabel else {
            return
        }
        
        textView.text = nil
        textView.textColor = .label
    }
}

extension MovieNoteViewController: MovieNoteProtocol {
    
    func darkModeCheck() {
        appearanceCheck(self)
    }
  
    func setupNavigationBar() {
        navigationItem.title = movieNote.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapLeftBarButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapRightBarButton))
        navigationController?.navigationBar.titleTextAttributes = [.font: uiFont]
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        [createdAtLabel, contentsTextView, shareButton].forEach {
            view.addSubview($0)
        }
        
        let spacing: CGFloat = 16.0
        
        createdAtLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(spacing)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8.0)
        }
        
        contentsTextView.snp.makeConstraints {
            $0.top.equalTo(createdAtLabel.snp.bottom).offset(spacing)
            $0.leading.equalToSuperview().inset(spacing)
            $0.trailing.equalToSuperview().inset(spacing)
            
        }
        
        shareButton.snp.makeConstraints {
            $0.top.equalTo(contentsTextView.snp.bottom).offset(spacing)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(spacing)
        }
    }
    
    func pushToMovieListViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func messageAlert(message: String, completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "삭제", style: .default) { _ in
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
    
    func didTapShareButton() {
        var activityItems: [String] = []
        let shareText = "제목: \(movieNote.title!)\n\n 작성일: \(movieNote.createdAt!)\n\n \(contentsTextView.text!)"
        activityItems.append(shareText)
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}

private extension MovieNoteViewController {
    @objc func didTapLeftBarButton() {
        // contents의 변경사항이 없으면
        if Constants.contentsTextViewPlaceholder == contentsTextView.text {
            pushToMovieListViewController()
        } else {
            presenter.didTapLeftBarButton(contentsTextView: contentsTextView.text)
        }
    }
    @objc func didTapRightBarButton() {
        presenter.didTapRightBarButton()
    }
    
}
