//
//  Movie.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/16.
//

import Foundation
import UIKit

final class Movie: Codable {
    let title: String
    private let image: String
    let pubDate: String?
    var pngImageData: Data?
    var imageURL: URL? {
        URL(string: image)
    }
    private enum CodingKeys: String, CodingKey {
        case title, image, pubDate
    }
    init(_ title: String, _ uiImage: UIImage) {
        self.pngImageData = uiImage.pngData()
        self.title = title
        self.pubDate = ""
        self.image = ""
    }
}
