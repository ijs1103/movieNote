//
//  Font.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/24.
//

import Foundation
import UIKit

enum Font: Int, CaseIterable {
   
    case igraSans
    case appleSDGothicNeo
    case nanumGothic
    case seoulNamsan
    case seoulHangang
    case ridiBatang
    
    static let fontNames = ["Igra Sans", "Apple SD Gothic Neo", "나눔고딕", "서울남산체", "서울한강체", "리디바탕체"]
    
    var uiFont: UIFont {
        switch self {
        case .igraSans:
            return UIFont(name: "IgraSans", size: 14.0)!
        case .appleSDGothicNeo:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 14.0)!
        case .nanumGothic:
            return UIFont(name: "NanumGothic", size: 14.0)!
        case .seoulNamsan:
            return UIFont(name: "SeoulNamsanM", size: 14.0)!
        case .seoulHangang:
            return UIFont(name: "SeoulHangangM", size: 14.0)!
        case .ridiBatang:
            return UIFont(name: "RIDIBatang", size: 14.0)!
        }
    }
}
