//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateBitcoinLabel(lastPrice:Float)
}

struct CoinManager {
    var delegate : CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "B6461CF9-6093-4AC4-8FF3-A7A078818D5C"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    //https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=B6461CF9-6093-4AC4-8FF3-A7A078818D5C
    func getCoinPrice(for currency: String){
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(urlString: urlString)
        print(urlString)
    }
    func performRequest(urlString:String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    if let price = self.parseJSON(coinData: safeData){
                        self.delegate?.didUpdateBitcoinLabel(lastPrice: price)
                    }
                }
            }
            task.resume()
        }
    
        
    }
    
    func parseJSON(coinData: Data)-> Float? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let lastprice = decodedData.rate
            return lastprice
        } catch {
            print(error)
            return nil
        }

}
}

