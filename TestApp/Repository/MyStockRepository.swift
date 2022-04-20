//
//  MyStockRepository.swift
//  TestApp
//
//  Created by iMac on 2022/04/20.
//

import Foundation
import Alamofire
import RxSwift

class MyStockRepository {
    func requestMyStock() -> Observable<[MyStockModel]> {
        return Observable.create { emitter in
            guard let url = URLInfo.stock.url else { return Disposables.create() }

            AF.request(url, method: .get)
                .responseDecodable(of: [MyStockModel].self) { response in
                    switch response.result {
                    case .success(let stocks):
                        emitter.onNext(stocks)
                        emitter.onCompleted()
                    case .failure(let error):
                        emitter.onError(error)
                    }
                }

            return Disposables.create()
        }
    }
}
