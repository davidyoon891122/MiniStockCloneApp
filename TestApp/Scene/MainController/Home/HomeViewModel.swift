//
//  HomeViewModel.swift
//  TestApp
//
//  Created by iMac on 2022/03/02.
//

import Foundation

class HomeViewMode {
    var onUpdate: () -> Void = {}
    
    var myStocks: [MyStockModel] = [
        MyStockModel(stockName: "--", currentPrice: 0, stockQuantity: 0, valueChange: 0, percentChange: 0, imageURL: "")
        ] {
        didSet {
            onUpdate()
        }
    }
    
    var profit: ProfitModel = ProfitModel(userName: "---", totalAsset: 0, valueChange: 0, percentChange: 0, referenceDay: "--") {
        didSet {
            onUpdate()
        }
    }
    
    var dividends: [DividendModel] = [
        DividendModel(stockName: "--", currentPrice: 0, percentChange: 0, imageURL: "", exDividendDate: "--")
    ] {
        didSet {
            onUpdate()
        }
    }
    
    private let networkManager = NetworkManager()
    
    func fetchMyStock() {
        networkManager.requestMyStock { myStocks in
            self.myStocks = myStocks
        }
    }
    
    func fetchProfit() {
        networkManager.requestProfit { profit in
            self.profit = profit
        }
    }
    
    func fetchDividendList() {
        networkManager.requestDividendList { dividends in
            self.dividends = dividends
        }
    }
}
