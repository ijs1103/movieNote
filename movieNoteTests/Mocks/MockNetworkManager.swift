//
//  MockNetworkManager.swift
//  movieNoteTests
//
//  Created by 이주상 on 2023/03/27.
//

import Foundation
@testable import movieNote

final class MockNetworkManager: NetworkManagerProtocol {
    var isCalledFetchMovie = false
    
    func fetchMovie(from keyword: String, completionHandler: @escaping NetworkCompletion) {
        isCalledFetchMovie = true
    }
}

