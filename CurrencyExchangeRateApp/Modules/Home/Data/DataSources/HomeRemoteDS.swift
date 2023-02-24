//
//  HomeRemoteDS.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 22/02/2023.
//

import Foundation

struct HomeRemoteDS {

    func fetchExchangeRates(completion: @escaping (Result<ExchangeRateAPIModel, Error>) -> ()) {
        NetworkManager.request(target: .exchangeRates, completion: completion)
    }
    
}
