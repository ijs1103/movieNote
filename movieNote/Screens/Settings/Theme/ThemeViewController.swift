//
//  ThemeViewController.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/23.
//
import SnapKit
import UIKit

final class ThemeViewController: UIViewController {
    
    private lazy var presenter = ThemePresenter(viewController: self)
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.label
        label.shadowColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.text = DarkMode().text
        
        return label
    }()
    
    private lazy var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = DarkMode().isDark
        switchButton.addTarget(self, action: #selector(didTapSwitch(sender:)), for: .valueChanged)
        
        return switchButton
    }()
    
    private struct DarkMode {
        var isDark: Bool {
            let appearance = UserDefaults.standard.string(forKey: "Appearance")
            return (appearance == "Dark")
        }
        var text: String {
            return isDark ? Constants.darkModeText : Constants.lightModeText
        }
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

extension ThemeViewController: ThemeProtocol {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        
        [label, switchButton].forEach {
            view.addSubview($0)
        }
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        switchButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(label.snp.bottom).offset(16.0)
        }
        
    }
    
    func darkModeCheck() {
        appearanceCheck(self)
    }
    
    func toggleDarkMode(sender: UISwitch) {
        if sender.isOn {
            label.text = Constants.darkModeText
            label.textColor = .white
            view.backgroundColor = .black
        } else {
            label.text = Constants.lightModeText
            label.textColor = .black
            view.backgroundColor = .white
        }
        if self.overrideUserInterfaceStyle == .light {
            UserDefaults.standard.set("Dark", forKey: "Appearance")
        } else {
            UserDefaults.standard.set("Light", forKey: "Appearance")
        }
    }
}

extension ThemeViewController {
    @objc func didTapSwitch(sender: UISwitch) {
        presenter.didTapSwitch(sender: sender)
    }
}
