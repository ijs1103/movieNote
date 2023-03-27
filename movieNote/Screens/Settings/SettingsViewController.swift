//
//  SettingsViewController.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/23.
//
import SnapKit
import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var presenter = SettingsPresenter(viewController: self)
    
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

extension SettingsViewController: SettingsProtocol {
    func setupNavigationBar() {
        navigationItem.title = "설정"
        let uiFont = FontManager.getFontStyle().uiFont
        navigationController?.navigationBar.titleTextAttributes = [.font: uiFont]
    }
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func darkModeCheck() {
        appearanceCheck(self)
    }

    func pushToThemeViewController() {
        let themeViewController = ThemeViewController()
        navigationController?.pushViewController(themeViewController, animated: true)
    }
    
    func pushToFontStyleViewController() {
        let fontStyleViewController = FontStyleViewController()
        navigationController?.pushViewController(fontStyleViewController, animated: true)
    }
    
    func pushToLicenseViewController() {
        let licenseViewController = LicenseViewController()
        navigationController?.pushViewController(licenseViewController, animated: true)
    }
}
