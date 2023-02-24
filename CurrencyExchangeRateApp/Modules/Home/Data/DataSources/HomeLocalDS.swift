//
//  HomeLocalDS.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 22/02/2023.
//

import RealmSwift

struct HomeLocalDS {
    
    //MARK: - Token
    static func saveExchangeRate(_ model: ExchangeRateAPIModel) {
        let rateArray = List<Rate>()
        for (key, value) in model.rates ?? [:] {
            rateArray.append(Rate(currency: key, rate: RealmOptional<Double>(value)))
        }
        let localModel = ExchangeRateLocalModel(disclaimer: model.disclaimer, license: model.license, base: model.base, rates: rateArray, timestamp: RealmOptional<Int>(Int(Date().timeIntervalSince1970)))
        DBManager.shared.saveObject(object: localModel)
    }
    
    static func getExchangeRate() -> ExchangeRateLocalModel? {
        return (DBManager.shared.getObjects(type: ExchangeRateLocalModel.self)?.first as? ExchangeRateLocalModel)
    
    }
    
}
