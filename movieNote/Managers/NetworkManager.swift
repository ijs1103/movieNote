//
//  NetworkManager.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/18.
//

import Alamofire
import Foundation

typealias NetworkCompletion = (Result<[Movie], Error>) -> Void

protocol NetworkManagerProtocol {
    func fetchMovie(from keyword: String, completionHandler: @escaping NetworkCompletion)
}

struct NetworkManager: NetworkManagerProtocol {
    func fetchMovie(from keyword: String, completionHandler: @escaping NetworkCompletion) {
        
        guard let url = URL(string: "https://openapi.naver.com/v1/search/movie.json") else { return }
        
        let parameters = [
            "query": keyword
        ]
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": Env.id,
            "X-Naver-Client-Secret": Env.secret
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: MovieResponseModel.self) { response in
            switch response.result {
            case let .success(result):
                completionHandler(.success(result.items))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
        .resume()
    }
}
