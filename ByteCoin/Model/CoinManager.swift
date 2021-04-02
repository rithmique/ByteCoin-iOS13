//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdateCoinPrice(_ coinManager: CoinManager, coinPrice: CryptoModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "secret"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var coinDelegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    coinDelegate?.didFailWithError(error: error!)
                }
                if let apiData = data {
                    if let bitcoinData = parseJSON(apiData) {
                        coinDelegate?.didUpdateCoinPrice(self, coinPrice: bitcoinData)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ coinData: Data) -> CryptoModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CryptoData.self, from: coinData)
            let price = decodedData.rate
            let currency = decodedData.asset_id_quote
            print("One bitcoin is equal \(price) in \(currency)")
            
            let coinPrice = CryptoModel(price: price, currency: currency)
            
            return coinPrice
        } catch {
            coinDelegate?.didFailWithError(error: error)
            return nil
        }
    }
}
