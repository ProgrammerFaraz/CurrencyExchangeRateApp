//
//  ExchangeRateAPIModel.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 22/02/2023.
//

import Foundation
import RealmSwift

struct ExchangeRateAPIModel: Codable {
    let disclaimer: String?
    let license: String?
    let base: String?
    let rates: [String: Double]?
    let timestamp: Int?

}

class ExchangeRateLocalModel: Object {
    @objc dynamic var id = "1"
    @objc dynamic var disclaimer: String?
    @objc dynamic var license: String?
    @objc dynamic var base: String?
    var rates = List<Rate>()
    var timestamp = RealmOptional<Int>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    override init() {}
    
    init(disclaimer: String?, license: String?, base: String?, rates: List<Rate>, timestamp: RealmOptional<Int>) {
        self.disclaimer = disclaimer
        self.license = license
        self.base = base
        self.rates = rates
        self.timestamp = timestamp
    }
}

class Rate: Object {
    @objc dynamic var currency: String?
    var rate = RealmOptional<Double>()
    override init() {}
    
    init(currency: String?, rate: RealmOptional<Double>) {
        self.currency = currency
        self.rate = rate
    }
}
