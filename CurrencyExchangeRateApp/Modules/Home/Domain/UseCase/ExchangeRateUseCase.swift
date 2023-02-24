//
//  ExchangeRateUseCase.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 23/02/2023.
//

import Foundation

protocol ExchangeRateUseCase {
    func fetchExchangeRates(method: FetchingType, completion: @escaping (ExchangeRateAPIModel?, ExchangeRateLocalModel?, String?) -> ())
}

class DefaultExchangeRateUseCase: ExchangeRateUseCase {
    private var homeRepository: HomeRepository
    
    init(homeRepository: HomeRepository) {
        self.homeRepository = homeRepository
    }
    /// To fetch search results
    /// - Parameters:
    ///   - query: search query string
    ///   - completion: closure to be executed once the search result is fetched from the server
    func fetchExchangeRates(method: FetchingType = .remote, completion: @escaping (ExchangeRateAPIModel?, ExchangeRateLocalModel?, String?) -> ()) {
        homeRepository.fetchExchangeRates(from: method) { remoteResponse, localResponse, errorMsg  in
            if let errorMsg = errorMsg {
                completion(remoteResponse, localResponse, errorMsg)
                return
            }
            completion(remoteResponse, localResponse, errorMsg)
        }
    }
}
