//
//  HomeViewModel.swift
//  TestApp
//
//  Created by iMac on 2022/03/02.
//

import Foundation
import RxSwift
import RxRelay

protocol HomeViewModelInput {
    func fetchMyStock()
    func fetchProfit()
    func fetchDividendList()
    func inOutBind()
}

protocol HomeViewModelOutput {
    var myStocksSubject: PublishSubject<[MyStockModel]> { get }
    var dividendsSubject: PublishSubject<[DividendModel]> { get }
    var profitsSubject: PublishSubject<ProfitModel> { get }
    var finishFetchSubject: PublishSubject<Bool> { get }
}

protocol HomeViewModelType {
    var inputs: HomeViewModelInput { get }
    var outputs: HomeViewModelOutput { get }
}

final class HomeViewModel: HomeViewModelType, HomeViewModelInput, HomeViewModelOutput {
    var inputs: HomeViewModelInput { self }

    var outputs: HomeViewModelOutput { self }

    private let disposeBag = DisposeBag()

    var myStocksSubject: PublishSubject<[MyStockModel]> = .init()

    var dividendsSubject: PublishSubject<[DividendModel]> = .init()

    var profitsSubject: PublishSubject<ProfitModel> = .init()

    var finishFetchSubject: PublishSubject<Bool> = .init()

    private let repository = StockRepository()

    private var myStockUrl: URL? = Config.serverInfo == .local
    ? URLInfo.stock.localURL
    : URLInfo.stock.url

    private var profitUrl: URL? = Config.serverInfo == .local
    ? URLInfo.profit.localURL
    : URLInfo.profit.url

    private var dividentUrl: URL? = Config.serverInfo == .local
    ? URLInfo.dividend.localURL
    : URLInfo.dividend.url
    
    func fetchMyStock() {
        repository.requestData(
            url: myStockUrl,
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
            url: profitUrl,
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
            url: dividentUrl,
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
