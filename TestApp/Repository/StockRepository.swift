//
//  StockRepository.swift
//  TestApp
//
//  Created by iMac on 2022/04/20.
//

import Foundation
import Alamofire
import RxSwift

class StockRepository {
    func requestData<T: Decodable>(url: URL?, type: T.Type) -> Observable<T> {
        return Observable.create { emitter in
            guard let url = url else { return Disposables.create() }

            AF.request(url, method: .get)
                .responseDecodable(of: type) { response in
                    switch response.result {
                    case .success(let data):
                        emitter.onNext(data)
                        emitter.onCompleted()
                    case .failure(let error):
                        emitter.onError(error)
                    }
                }
            return Disposables.create()
        }
    }
}
