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

    private let repository = StockRepository()

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
