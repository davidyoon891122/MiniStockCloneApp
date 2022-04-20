//
//  HomeViewModel.swift
//  TestApp
//
//  Created by iMac on 2022/03/02.
//

import Foundation
import RxSwift
import RxRelay

class HomeViewModel {
    private let disposeBag = DisposeBag()

    var onUpdate: () -> Void = {}
    var myStocksSubject: PublishSubject<[MyStockModel]> = PublishSubject<[MyStockModel]>()
    var myStocksRelay: PublishRelay<[MyStockModel]> = .init()
    var myStocks: [MyStockModel] = [
        MyStockModel(
            stockName: "--",
            currentPrice: 0,
            stockQuantity: 0,
            valueChange: 0,
            percentChange: 0,
            imageURL: ""
        )
        ] {
        didSet {
            onUpdate()
        }
    }
    
    var profit: ProfitModel = ProfitModel(
        userName: "---",
        totalAsset: 0,
        valueChange: 0,
        percentChange: 0,
        referenceDay: "--"
    ) {
        didSet {
            onUpdate()
        }
    }
    
    var dividends: [DividendModel] = [
        DividendModel(
            stockName: "--",
            currentPrice: 0,
            percentChange: 0,
            imageURL: "",
            exDividendDate: "--"
        )
    ] {
        didSet {
            onUpdate()
        }
    }
    
    private let networkManager = NetworkManager()

    private let repository = MyStockRepository()
    
    func fetchMyStock() {
        repository.requestMyStock()
            .subscribe(onNext: { myStocks in
                self.myStocksSubject.onNext(myStocks)
                self.myStocksRelay.accept(myStocks)
            }, onError: { error in
                self.myStocksSubject.onError(error)
            }
            )
            .disposed(by: disposeBag)

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
