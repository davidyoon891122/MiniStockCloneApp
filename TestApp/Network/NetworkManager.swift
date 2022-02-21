//
//  NetworkManager.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    func requestMyStock(completionHandler: @escaping ((([MyStock]) -> Void))) {
        guard let url = URL(string: "https://boiling-scrubland-57180.herokuapp.com/my-stock") else { return }
        
        AF.request(url, method: .get)
            .responseDecodable(of: [MyStock].self) { response in
                switch response.result {
                case .success(let result):
                    completionHandler(result)
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }
}
