//
//  API.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 23/02/2023.
//

import Moya

enum API {
    case exchangeRates
}

extension API: TargetType {
    var baseURL: URL {
        guard let url = URL(string: Constants.baseURL) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .exchangeRates:
            return "latest.json"
        }
    }
    
    var method: Method {
        switch self {
        case .exchangeRates:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .exchangeRates:
            return .requestParameters(parameters: ["app_id": Constants.openExchangeAppID], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
