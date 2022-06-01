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

    var myStocksSubject: PublishSubject<[MyStockModel]> = .init()

    var dividendsSubject: PublishSubject<[DividendModel]> = .init()

    var profitsSubject: PublishSubject<ProfitModel> = .init()

    var finishFetchSubject: PublishSubject<Bool> = .init()

    private let repository = StockRepository()
    
    func fetchMyStock() {
        repository.requestData(
            url: URLInfo.stock.localURL,
            type: [MyStockModel].self
        )
            .debug()
            .subscribe(onNext: { myStocks in
                self.myStocksSubject.onNext(myStocks)
            }, onError: { error in
                self.myStocksSubject.onError(error)
            }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchProfit() {
        repository.requestData(
            url: URLInfo.profit.localURL,
            type: [ProfitModel].self
        )
            .debug()
            .subscribe(onNext: { profits in
                self.profitsSubject.onNext(profits[0])
            }, onError: { error in
                self.profitsSubject.onError(error)
            }
            )
            .disposed(by: disposeBag)
    }
    
    func fetchDividendList() {
        repository.requestData(
            url: URLInfo.dividend.localURL,
            type: [DividendModel].self
        )
            .debug()
            .subscribe(onNext: { dividends in
                self.dividendsSubject.onNext(dividends)
            }, onError: { error in
                self.dividendsSubject.onError(error)
            })
            .disposed(by: disposeBag)
    }

    func inOutBind() {
        Observable.combineLatest(
            myStocksSubject,
            dividendsSubject,
            profitsSubject,
            resultSelector: { !$0.isEmpty && !$1.isEmpty && !$2.userName.isEmpty })
            .debug()
            .bind(to: finishFetchSubject)
            .disposed(by: disposeBag)

    }
}
