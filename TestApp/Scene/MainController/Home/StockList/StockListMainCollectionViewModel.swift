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

    private var increaseUrl: URL? = Config.serverInfo == .local
    ? URLInfo.increase.localURL
    : URLInfo.increase.url

    func fetchIncreaseList() {
        repository.requestData(
            url: increaseUrl,
            type: [IncreaseStockModel].self
        )
            .subscribe(onNext: {
                self.increasedStocksSubject.onNext($0)
            })
            .disposed(by: disposeBag)
    }
    
}
