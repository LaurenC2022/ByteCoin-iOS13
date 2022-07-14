//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func didUpdateView(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "?apikey=PUT_APIKEY_HERE"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
}

//MARK: - Get convertion rate

extension CoinManager{
    
    func performRequest(for currency: String){
        let urlString = baseURL + currency + apiKey
        //print(urlString)
        
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print(error!)//handles errors like loss of internet connection
                    return
                }
                if let safeData = data{
                    if let coin = self.parseJSON(safeData){
                   
                        self.delegate?.didUpdateView(self, coin: coin)
                    
                    }
                    /* //test for data retrieving before CoinData, CoinModel and decodable was written
                     let dataString = String(data: safeData, encoding: String.Encoding.utf8) as String?
                     print(dataString!)
                     */
                }
            }
            task.resume()
        }
        
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel?{
        let decoder = JSONDecoder() //object that can decode JSON that Apple developers created
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)// WeatherData is a data type, not an object, in this instance that conforms to decodable protocal. Add self keyword to use weatherData as a data type instead of an object
            //handle errors with decoding. Examples of errors: JSON not matching format in WeatherData or data did not return from internet properly
            
            let time = decodedData.time
            let asset_id_base = decodedData.asset_id_base
            let asset_id_quote = decodedData.asset_id_quote
            let rate = decodedData.rate
            
            
            let coin = CoinModel(time: time, asset_id_base: asset_id_base, asset_id_quote: asset_id_quote, rate: rate)
            
            print(decodedData.rate)
            
            return coin
            
        } catch{
              delegate?.didFailWithError(error: error)//handle errors with decoding, like JSON not matching format in WeatherData or data did not return from internet properly
            return nil
        }
        //Decodable has a thow, which can result in an error. Add try, also a do/catch statement in case it crashes
    }
}
