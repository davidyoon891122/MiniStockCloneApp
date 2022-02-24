//
//  DividendModel.swift
//  TestApp
//
//  Created by iMac on 2022/02/24.
//

import Foundation

struct DividendModel: Decodable {
    let stockName: String
    let currentPrice: Int
    let percentChange: Float
    let imageURL: String?
    let exDividendDate: String
}
