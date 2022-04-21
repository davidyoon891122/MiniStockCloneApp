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

    var dividendsSubject: PublishSubject<[DividendModel]> = PublishSubject<[DividendModel]>()
    var dividendsRelay: PublishRelay<[DividendModel]> = .init()

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
    
    private let networkManager = NetworkManager()

    private let repository = StockRepository()
    
    func fetchMyStock() {
        repository.requestData(url: URLInfo.stock.url, type: [MyStockModel].self)
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
        repository.requestData(url: URLInfo.dividend.url, type: [DividendModel].self)
            .subscribe(onNext: { dividends in
                print(dividends)
                self.dividendsSubject.onNext(dividends)
                self.dividendsRelay.accept(dividends)
            }, onError: { error in
                print(error)
                self.dividendsSubject.onError(error)
            })
            .disposed(by: disposeBag)
    }
}
