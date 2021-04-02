//
//  cryptoData.swift
//  ByteCoin
//
//  Created by Максим on 02.04.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CryptoData: Codable {
    
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
