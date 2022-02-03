//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func didUpdateCoin(of coinModel: CoinModel)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "C0358DA2-BA5A-43D1-BB65-D278166B8494"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoindPrice(for currency: String){
        let url = "\(baseURL)/\(currency)?apiKey=\(apiKey)"
        print(url)
        performRequest(with: url)
        
    }
    
    func performRequest(with url: String){
        if let urlValidate = URL(string: url) {
            let session = URLSession.init(configuration: .default)
            let task = session.dataTask(with: urlValidate) { data, urlResponse, error in
                if error != nil {
                    print(error)
                    return
                }
                
                if let dataValid = data {
                    guard let coinModelRetor = parseJSON(of: dataValid) else {
                        
                        return
                    }
                    
                    self.delegate?.didUpdateCoin(of: coinModelRetor)
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(of bitcoin: Data) -> CoinModel? {
        let decoder = JSONDecoder();
        do {
            let decoderData = try decoder.decode(CoindData.self, from: bitcoin)
            return CoinModel(countyName: decoderData.asset_id_quote, bitCoin: decoderData.rate)
        }catch {
            print(error)
            return nil
        }
        
    }
}
