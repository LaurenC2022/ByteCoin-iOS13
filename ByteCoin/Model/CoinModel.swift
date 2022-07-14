//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Lauren Collins on 7/13/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel{

    let asset_id_quote: String
    let rate: Float
    
    var coinString: String{
        return String(format: "%.2f", rate)
    }
}
