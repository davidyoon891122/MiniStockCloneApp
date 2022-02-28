//
//  ProfitModel.swift
//  TestApp
//
//  Created by iMac on 2022/02/23.
//

import Foundation

struct ProfitModel: Decodable {
    let userName: String
    let totalAsset: Int
    let valueChange: Int
    let percentChange: Float
    let referenceDay: String
}
