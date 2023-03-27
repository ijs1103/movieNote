//
//  FontManager.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/24.
//

import Foundation

protocol FontManagerProtocol {
    static func getFontStyle() -> Font
    static func setFontStyle(font: Font)
}

struct FontManager: FontManagerProtocol {
    
    static func getFontStyle() -> Font {
        if let font = (UserDefaults.standard.value(forKey: "Font") as AnyObject).integerValue {
            return Font(rawValue: font)!
        } else {
            return .appleSDGothicNeo
        }
    }
    
    static func setFontStyle(font: Font) {
        UserDefaults.standard.setValue(font.rawValue, forKey: "Font")
    }
}
