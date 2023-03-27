//
//  ThemePresenter.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/23.
//

import Foundation
import UIKit

protocol ThemeProtocol: AnyObject {
    func setupViews()
    func darkModeCheck()
    func toggleDarkMode(sender: UISwitch)
}

final class ThemePresenter: NSObject {
    private weak var viewController: ThemeProtocol?
    
    private let fontItems: [String] = ["폰트 스타일", "폰트 크기"]
                
    init(viewController: ThemeProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        viewController?.darkModeCheck()
    }
    
    func didTapSwitch(sender: UISwitch) {
        viewController?.toggleDarkMode(sender: sender)
    }
}
