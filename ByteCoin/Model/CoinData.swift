//
//  CoinData.swift
//  ByteCoin
//
//  Created by Lauren Collins on 7/13/22.
//  Copyright © 2022 The App Brewery. All rights reserved.
//

import Foundation


struct CoinData: Decodable{
    
    let time: String
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Float
}
