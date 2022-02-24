//
//  MyStock.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import Foundation

struct MyStockModel: Decodable {
    let stockName: String
    let currentPrice: Int
    let stockQuantity: Float
    let valueChange: Int
    let percentChange: Float
    let imageURL: String?
}
