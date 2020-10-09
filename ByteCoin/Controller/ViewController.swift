//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var coinManager = CoinManager()
    

    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var bitcoinLabel: UILabel!

    
    override func viewDidLoad() {
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
//MARK: -UIPickerViewDataSource
extension ViewController:UIPickerViewDataSource, UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        currencyLabel.text = selectedCurrency
    
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
//MARK: -CoinManagerDelegate

extension ViewController : CoinManagerDelegate {
    func didUpdateBitcoinLabel(lastPrice:Float){
        let price = String(format:"%.2f", lastPrice)
        
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            
        }
    }
}
