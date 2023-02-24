//
//  CurrencyConversionUseCase.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 24/02/2023.
//

import Foundation

protocol CurrencyConversionUseCase {
    func convertCurrency(from: Double, to: Double, with amount: Double) -> Double
}

class DefaultCurrencyConversionUseCase: CurrencyConversionUseCase {
    
    var amount, from, to: Double?
    
    init() {}

    func convertCurrency(from: Double, to: Double, with amount: Double) -> Double {
        return amount*(from/to)
    }
    
}
