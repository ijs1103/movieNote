//
//  AppearanceCheck.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/23.
//
import UIKit

extension UIViewController {
    func appearanceCheck(_ viewController: UIViewController) {
        guard let appearance = UserDefaults.standard.string(forKey: "Appearance") else { return }
        if appearance == "Dark" {
            viewController.overrideUserInterfaceStyle = .dark
            viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            viewController.overrideUserInterfaceStyle = .light
            viewController.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        }
    }
}
