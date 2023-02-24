//
//  TimestampConverter.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 24/02/2023.
//

import Foundation

class TimestampConverter {
    
    static func convert(from timestamp: Int) -> Double {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        return abs((date.timeIntervalSinceNow)/60)
    }
}
