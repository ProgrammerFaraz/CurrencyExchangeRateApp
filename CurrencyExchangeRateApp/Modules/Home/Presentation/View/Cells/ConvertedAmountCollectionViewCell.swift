//
//  ConvertedAmountCollectionViewCell.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 24/02/2023.
//

import UIKit

class ConvertedAmountCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ConvertedAmountCollectionViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(title: String, convertedValue: Double) {
        let formattedValue = String(format: "%.3f", convertedValue)
        self.titleLabel.text = "\(formattedValue)\n\(title)"
    }
}
