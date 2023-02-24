//
//  HomeRepository.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 22/02/2023.
//

import Foundation

class HomeRepository {
    
    private var remoteDataSource: HomeRemoteDS!
    private var localDataSource: HomeLocalDS!

    init() {
        remoteDataSource = HomeRemoteDS()
        localDataSource = HomeLocalDS()
    }
    
    func fetchExchangeRates(from method: FetchingType, completion:@escaping (ExchangeRateAPIModel?, ExchangeRateLocalModel?, String?) -> ()) {
        switch method {
        case .remote:
            remoteDataSource.fetchExchangeRates { result in
                switch result {
                case .success(let response):
                    completion(response, nil, nil)
                case .failure(let error):
                    completion(nil, nil, error.localizedDescription)
                }
            }
        case .local:
            completion(nil, HomeLocalDS.getExchangeRate(), nil)
        }
    }
    
}
