//
//  MovieResponseModel.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/18.
//

import Foundation

struct MovieResponseModel: Codable {
    let query, kmaQuery: String
    let totalCount: Int
    let data: [Datum]

    enum CodingKeys: String, CodingKey {
        case query = "Query"
        case kmaQuery = "KMAQuery"
        case totalCount = "TotalCount"
        case data = "Data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let collName: String
    let totalCount, count: Int
    let movies: [Movie]

    enum CodingKeys: String, CodingKey {
        case collName = "CollName"
        case totalCount = "TotalCount"
        case count = "Count"
        case movies = "Result"
    }
}
