//
//  cryptoModel.swift
//  ByteCoin
//
//  Created by Максим on 02.04.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CryptoModel {
    let price: Double
    let currency: String
    
    var priceConverted: String {
        return String(format: "%.2f", price)
    }
}
