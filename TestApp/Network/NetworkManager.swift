//
//  NetworkManager.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import Foundation
import Alamofire

struct NetworkManager {
    
//    private let baseURL = "https://boiling-scrubland-57180.herokuapp.com/"
    private let baseURL = "http://127.0.0.1:3000/"

    func requestMyStock(completionHandler: @escaping (([MyStockModel]) -> Void)) {
        guard let url = URL(string: baseURL + "my-stock") else { return }
        
        AF.request(url, method: .get)
            .responseDecodable(of: [MyStockModel].self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func requestProfit(completionHandler: @escaping (((ProfitModel) -> Void))) {
        guard let url = URL(string: baseURL + "my-profit") else { return }
        
        AF.request(url, method: .get)
            .responseDecodable(of: [ProfitModel].self) { response in
                switch response.result {
                case .success(let result):
                    print(result)
                    completionHandler(result[0])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func requestDividendList(completionHandler: @escaping (([DividendModel]) -> Void)) {
        guard let url = URL(string: baseURL + "dividend-list") else { return }
        
        AF.request(url, method: .get)
            .responseDecodable(of: [DividendModel].self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func requestIncreaseList(completionHandler: @escaping ([IncreaseStockModel]) -> Void) {
        guard let url = URL(string: baseURL + "increase-list") else { return }
        AF.request(url, method: .get)
            .responseDecodable(of: [IncreaseStockModel].self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .resume()
    }
    
    func requestMyStockWithoutAF(completionHandler: @escaping (([MyStockModel]) -> Void)) {
        guard let url = URL(string: baseURL + "my-stock") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let jsonData = try? JSONDecoder().decode([MyStockModel].self, from: data)
            guard let stocks = jsonData else { return }
            completionHandler(stocks)
        }
        .resume()

    }
}
