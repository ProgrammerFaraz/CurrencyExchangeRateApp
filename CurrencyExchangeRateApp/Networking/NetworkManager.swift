//
//  NetworkManager.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 23/02/2023.
//

import Foundation
import Moya

enum FetchingType {
    case remote
    case local
//    case remoteUpdateLocal
//    case localFetchingRemote
//    case automatic
}

protocol APIRequestProtocol {
    static func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ())
}

class NetworkManager: APIRequestProtocol {
    
    static var provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin()])
    
    /// Generic method for remote network request
    /// - Parameters:
    ///   - target: Type of use case
    ///   - completion: Returns a generic response model
    static func request<T: Decodable>(target: API, completion: @escaping (Result<T, Error>) -> ()) {
        NetworkManager.provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
