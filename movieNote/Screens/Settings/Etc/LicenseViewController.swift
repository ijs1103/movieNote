//
//  LicenseViewController.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/25.
//
import SnapKit
import UIKit

class LicenseViewController: UIViewController {
    
    private lazy var presenter = LicensePresenter(viewController: self)
    
    private let textView: UITextView = {
        let uiTextView = UITextView()
        uiTextView.textColor = .secondaryLabel
        uiTextView.text = Constants.licenseText
        let uiFont = FontManager.getFontStyle().uiFont
        uiTextView.font = uiFont
        
        return uiTextView
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
extension LicenseViewController: LicenseProtocol {

    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
    
    func darkModeCheck() {
        appearanceCheck(self)
    }
}
