//
//  FontStylePresenter.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/24.
//

import Foundation
import UIKit

protocol FontStyleProtocol: AnyObject {
    func setupViews()
    func setUIFont()
    func darkModeCheck()
}

final class FontStylePresenter: NSObject {
    private weak var viewController: FontStyleProtocol?
    
    private let fontStyles = Font.fontNames
    
    private let savedFontIndex = FontManager.getFontStyle().rawValue
    
    init(viewController: FontStyleProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        viewController?.darkModeCheck()
        viewController?.setUIFont()
    }
}

extension FontStylePresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // userdefaults에 저장된 Font style을 check 해제
        let savedFontIndexPath = IndexPath(row: savedFontIndex, section: 0)
        let savedFontCell = tableView.cellForRow(at: savedFontIndexPath)
        savedFontCell?.accessoryType = .none
        
        let selectedCell = tableView.cellForRow(at: indexPath)
        let selectedFont = Font.allCases[indexPath.row]
        // setFont
        FontManager.setFontStyle(font: selectedFont)
        selectedCell?.accessoryType = .checkmark
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let notSelectedCell = tableView.cellForRow(at: indexPath)
        notSelectedCell?.accessoryType = .none
    }
}

extension FontStylePresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontStyles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = fontStyles[indexPath.row]
        Font.allCases.forEach { font in
            cell.textLabel?.font = font.uiFont
        }
        cell.selectionStyle = .none
       
        if fontStyles[savedFontIndex] == fontStyles[indexPath.row] {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
}
