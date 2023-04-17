//
//  Movie.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/16.
//

import Foundation
import UIKit

final class Movie: Codable {
    
    var title: String {
        return rawTitle.replacingOccurrences(of: "!HS", with: "").replacingOccurrences(of: "!HE", with: "").trimmingCharacters(in: .whitespaces)
    }
    private let rawTitle: String
    private let image: String
    let pubDate: String?
    var jpegData: Data?
    var imageURL: URL? {
        URL(string: image)
    }
    private enum CodingKeys: String, CodingKey {
        case rawTitle = "title"
        case image = "posters"
        case pubDate = "prodYear"
    }
    init(_ title: String, _ uiImage: UIImage) {
        self.jpegData = uiImage.jpegData(compressionQuality: 0.9)
        self.rawTitle = title
        self.pubDate = ""
        self.image = ""
    }
}
