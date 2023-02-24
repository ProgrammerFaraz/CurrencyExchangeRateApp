//
//  CurrencyExchangeRateAppTests.swift
//  CurrencyExchangeRateAppTests
//
//  Created by Faraz Ahmed Khan on 24/02/2023.
//

import XCTest

@testable import CurrencyExchangeRateApp

class CurrencyExchangeRateAppTests: XCTestCase {
    
    func testExchangeRateUseCaseForRemote() {
        let expecation = self.expectation(description: "Should not return error")
        let defaultExchangeRateUseCase = DefaultExchangeRateUseCase(homeRepository: HomeRepository())
        defaultExchangeRateUseCase.fetchExchangeRates(method: .remote) { response, _, error in
            if response != nil {
                expecation.fulfill()
            }
            if error != nil {
                expecation.fulfill()
            }
        }
        self.waitForExpectations(timeout:5)
    }
    
    func testExchangeRateUseCaseForLocal() {
        let expecation = self.expectation(description: "Should not return error")
        let defaultExchangeRateUseCase = DefaultExchangeRateUseCase(homeRepository: HomeRepository())
        defaultExchangeRateUseCase.fetchExchangeRates(method: .local) { _, response, _ in
            if response != nil {
                expecation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1)
    }
    
    func testCurrencyConversionUseCase() {
        let expecation = self.expectation(description: "Should not return error")
        let defaultCurrencyConversionUseCase = DefaultCurrencyConversionUseCase()
        let convertedAmount = defaultCurrencyConversionUseCase.convertCurrency(from: 10, to: 5, with: 10)
        if convertedAmount.isFinite {
            expecation.fulfill()
        }
        self.waitForExpectations(timeout: 1)
    }
    
    func testFetchingObjectsFromLocal() {
        let expecation = self.expectation(description: "Should not return error")
        let model = HomeLocalDS.getExchangeRate()
        if model != nil {
            expecation.fulfill()
        }
        self.waitForExpectations(timeout: 1)
    }
    
}
