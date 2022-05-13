//
//  StockListMainCollectionViewModel.swift
//  TestApp
//
//  Created by iMac on 2022/03/02.
//

import Foundation

class StockListMainCollectionViewModel {
    var onUpdate: () -> Void = {}
    
    var inscreaseStocks: [IncreaseStockModel] = [
        IncreaseStockModel(
            stockName: "--",
            stockCode: "--",
            percentChange: 0,
            currentPrice: 0,
            imageURL: "'"
        )
    ] {
        didSet {
            onUpdate()
        }
    }
    
    private let networkManager = NetworkManager()
    
    func fetchIncreaseList() {
        networkManager.requestIncreaseList { increaseStocks in
            self.inscreaseStocks = increaseStocks
        }
    }
    
}
