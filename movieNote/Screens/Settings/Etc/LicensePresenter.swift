//
//  LicensePresenter.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/25.
//

import Foundation
import UIKit

protocol LicenseProtocol: AnyObject {
    func setupViews()
    func darkModeCheck()
}

final class LicensePresenter: NSObject {
    private weak var viewController: LicenseProtocol?
            
    init(viewController: LicenseProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupViews()
    }
    
    func viewWillAppear() {
        viewController?.darkModeCheck()
    }
}
