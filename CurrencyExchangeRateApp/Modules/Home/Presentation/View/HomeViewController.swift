//
//  HomeViewController.swift
//  CurrencyExchangeRateApp
//
//  Created by Faraz Ahmed Khan on 17/02/2023.
//

import UIKit
import DropDown
import RealmSwift

class HomeViewController: UIViewController {

    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var amountTextField: UITextField!

    var viewModel: DefaultHomeViewModel?
    let dropDown = DropDown()
    var currencies = [String]()
    var currencyRateDict = [String: Double]()
    var convertedRates = [Double]()
    var selectedCurrency = ""
    var selectedRate: Double = 1.0
    var amountEntered: Double = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindHomeViewModel()
        if checkIf30MinutesPassed() {
            viewModel?.fetchExchangeRates(method: .remote)
        } else {
            viewModel?.fetchExchangeRates(method: .local)
        }
        setupCollectionView()
        setupTextfield()
    }

    private func bindHomeViewModel() {
        viewModel?.onSuccess = { [weak self] in
            guard let self = self,
            let array = self.viewModel?.exchangeRateLocalModel?.rates
            else { return }
            
            for value in array {
                self.currencyRateDict[value.currency ?? ""] = (value.rate.value ?? 0.0)
            }
            
            self.currencies = Array(array.lazy.map{$0.currency ?? ""}).sorted()
            self.convertedRates = Array(array.lazy.map{$0.rate.value ?? 0.0})
            self.setupDropDown()
            self.dropDown.reloadAllComponents()
            self.collectionView.reloadData()
        }
        viewModel?.onError = { [weak self] error in
            print("Error: ", error)
        }
    }
    
    private func checkIf30MinutesPassed() -> Bool {
        guard let localModel = self.viewModel?.exchangeRateLocalModel else { return true }
        let minutes = TimestampConverter.convert(from: localModel.timestamp.value ?? 0)
        return minutes > 30
    }
    
    private func setupTextfield() {
        amountTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_: UITextField) {
        if (amountTextField.text ?? "").isEmpty {
            self.selectedRate = 1.0
        }
        amountEntered = Double(amountTextField.text ?? "1.0") ?? 1.0
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    private func setupDropDown() {
        
        dropDown.anchorView = dropDownButton
        dropDown.dataSource = currencies
        
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)

        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            self.dropDownLabel.text = item
            self.selectedCurrency = item
            self.selectedRate = self.currencyRateDict[item] ?? 1.0
            self.amountEntered = Double(self.amountTextField.text ?? "1.0") ?? 1.0
            self.collectionView.reloadData()
        }
    }

    @IBAction func dropDownTapped(_ sender: UIButton) {
        dropDown.show()
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConvertedAmountCollectionViewCell.identifier, for: indexPath) as? ConvertedAmountCollectionViewCell else {
            return UICollectionViewCell()
        }
        self.viewModel?.convertCurrency(from: (currencyRateDict[currencies[indexPath.item]] ?? 0.0), to: selectedRate, with: amountEntered)
        cell.configure(title: currencies[indexPath.item], convertedValue: self.viewModel?.convertedValue ?? 0.0)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.width/4)
    }
}
