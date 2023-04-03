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
        
        guard let url = URL(string: "http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp") else { return }
        
        let parameters = [
            "collection": "kmdb_new2",
            "listCount": "20",
            "ServiceKey": Env.ServiceKey,
            "title": keyword
        ]

        AF.request(url, method: .get, parameters: parameters, headers: nil).responseDecodable(of: MovieResponseModel.self) { response in
            switch response.result {
            case let .success(result):
                completionHandler(.success(result.data[0].movies))
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
        .resume()
    }
}
