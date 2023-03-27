//
//  MovieResponseModel.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/18.
//

import Foundation

struct MovieResponseModel: Decodable {
    var items: [Movie] = []
}
