//
//  NetworkManager.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    let baseURL = "https://boiling-scrubland-57180.herokuapp.com/"
    
    func requestMyStock(completionHandler: @escaping ((([MyStock]) -> Void))) {
        guard let url = URL(string: baseURL + "my-stock") else { return }
        
        AF.request(url, method: .get)
            .responseDecodable(of: [MyStock].self) { response in
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
                    completionHandler(result[0])
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
