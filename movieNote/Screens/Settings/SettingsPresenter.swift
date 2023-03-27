//
//  SettingsPresenter.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/23.
//

import UIKit

protocol SettingsProtocol: AnyObject {
    func setupNavigationBar()
    func setupViews()
    func darkModeCheck()
    func pushToThemeViewController()
    func pushToFontStyleViewController()
    func pushToLicenseViewController()
}

final class SettingsPresenter: NSObject {
    private weak var viewController: SettingsProtocol?
        
    private let sections: [String] = ["Theme", "Font", "Etc"]
    
    private var uiFont: UIFont {
        return FontManager.getFontStyle().uiFont
    }
            
    init(viewController: SettingsProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        viewController?.darkModeCheck()
    }
}

extension SettingsPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            viewController?.pushToThemeViewController()
        case 1:
            viewController?.pushToFontStyleViewController()
        case 2:
            viewController?.pushToLicenseViewController()
        default:
            return
        }
    }
}

extension SettingsPresenter: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.font = uiFont
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "다크 모드"
        case 1:
            cell.textLabel?.text = "폰트 스타일"
        case 2:
            cell.textLabel?.text = "라이센스"
        default:
            cell.textLabel?.text = ""
        }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header")
        header?.textLabel?.font = uiFont
        
        return header
    }
}
