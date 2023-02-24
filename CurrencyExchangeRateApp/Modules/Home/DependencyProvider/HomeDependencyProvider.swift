//
//  HomeDependencyProvider.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 22/02/2023.
//

import Foundation
import UIKit

struct HomeDependencyProvider {
    
    static var homeRepository: HomeRepository {
        return HomeRepository()
    }
    
    static var exchangeRateUseCase: ExchangeRateUseCase {
        return DefaultExchangeRateUseCase(homeRepository: homeRepository)
    }
    
    static var currencyConversionUseCase: CurrencyConversionUseCase {
        return DefaultCurrencyConversionUseCase()
    }
    
    static var viewModel: DefaultHomeViewModel {
        return DefaultHomeViewModel(exchangeRateUseCase: exchangeRateUseCase, currencyConversionUseCase: currencyConversionUseCase)
    }

    static var viewController: UIViewController {
        guard let vc = UIStoryboard(name: Storyboard.main,
                                    bundle: nil).instantiateInitialViewController() as? HomeViewController else { return UIViewController() }
        vc.viewModel = viewModel
        return vc
    }
}
