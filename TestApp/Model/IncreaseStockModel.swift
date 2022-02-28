//
//  IncreaseStockModel.swift
//  TestApp
//
//  Created by iMac on 2022/02/24.
//

import Foundation

struct IncreaseStockModel: Decodable {
    let stockName: String
    let stockCode: String
    let percentChange: Float
    let currentPrice: Int
    let imageURL: String?
}
