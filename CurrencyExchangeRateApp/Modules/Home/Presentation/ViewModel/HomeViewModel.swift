//
//  HomeViewModel.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 22/02/2023.
//

import Foundation

protocol HomeViewModel {
    func fetchExchangeRates(method: FetchingType)
}

class DefaultHomeViewModel: HomeViewModel {
    
    private var exchangeRateUseCase: ExchangeRateUseCase
    private var currencyConversionUseCase: CurrencyConversionUseCase
    var exchangeRateLocalModel: ExchangeRateLocalModel?
    var convertedValue = 0.0

    var onSuccess: (()->Void)?
    var onError: ((String)->Void)?
    
    init(exchangeRateUseCase: ExchangeRateUseCase, currencyConversionUseCase: CurrencyConversionUseCase) {
        self.exchangeRateUseCase = exchangeRateUseCase
        self.currencyConversionUseCase = currencyConversionUseCase
        self.exchangeRateLocalModel = HomeLocalDS.getExchangeRate()
    }

    func fetchExchangeRates(method: FetchingType) {
        exchangeRateUseCase.fetchExchangeRates(method: method) { [weak self] remoteResponse, localResponse, errorMsg in
            guard let self = self else { return }
            if let errorMsg = errorMsg {
                self.onError?(errorMsg)
                return
            }
            if let remoteResponse = remoteResponse {
                HomeLocalDS.saveExchangeRate(remoteResponse)
                self.onSuccess?()
                return
            }
            self.exchangeRateLocalModel = localResponse
            self.onSuccess?()
        }
    }
    
    func convertCurrency(from: Double, to: Double, with amount: Double) {
        convertedValue = currencyConversionUseCase.convertCurrency(from: from, to: to, with: amount)
    }
    
}
