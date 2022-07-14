//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    
    //MARK: - required delegate funtions
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //function required by UIPickerViewDataSource delegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    //function required by UIPickerViewDataSource delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //function optional for UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print(coinManager.currencyArray[row])
        
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.performRequest(for: selectedCurrency)
    }
    
    //MARK: - UI elements outlets
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var CurrencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    var coinManager = CoinManager()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
    }
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate{
    func didUpdateView(_ coinManager: CoinManager, coin: CoinModel) {
        
        DispatchQueue.main.async {
            self.CurrencyLabel.text = coin.asset_id_quote
            self.bitcoinLabel.text = coin.coinString
        }
    }
}
