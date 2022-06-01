//
//  StockListMainCollectionViewModel.swift
//  TestApp
//
//  Created by iMac on 2022/03/02.
//

import Foundation
import RxSwift

class StockListMainCollectionViewModel {
    private let disposeBag = DisposeBag()
    var onUpdate: () -> Void = {}

    private let repository = StockRepository()

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

    var increasedStocksSubject: PublishSubject<[IncreaseStockModel]> = .init()

    func fetchIncreaseList() {
        repository.requestData(
            url: URLInfo.increase.localURL,
            type: [IncreaseStockModel].self
        )
            .subscribe(onNext: {
                self.increasedStocksSubject.onNext($0)
            })
            .disposed(by: disposeBag)
    }
    
}
