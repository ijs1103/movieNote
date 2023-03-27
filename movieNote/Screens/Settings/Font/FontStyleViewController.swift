//
//  FontStyleViewController.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/24.
//
import SnapKit
import UIKit

final class FontStyleViewController: UIViewController {
    
    private lazy var presenter = FontStylePresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = presenter
        tableView.delegate = presenter
        
        return tableView
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

extension FontStyleViewController: FontStyleProtocol {

    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setUIFont() {
        let uiFont = FontManager.getFontStyle().uiFont
        navigationController?.navigationBar.titleTextAttributes = [.font: uiFont]
    }
    
    func darkModeCheck() {
        appearanceCheck(self)
    }
}
