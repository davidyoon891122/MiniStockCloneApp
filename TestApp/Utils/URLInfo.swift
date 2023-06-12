//
//  URLInfo.swift
//  TestApp
//
//  Created by iMac on 2022/04/20.
//

import Foundation

enum URLInfo {
    case stock
    case dividend
    case profit
    case increase

    var url: URL? {
        switch self {
        case .stock:
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/mini/my-stock")
        case .dividend:
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/mini/dividend-list")
        case .profit:
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/mini/my-profit")
        case .increase:
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/mini/increase-list")
        }
    }

    var localURL: URL? {
        switch self {
        case .stock:
            return URL(string: "http://127.0.0.1:3000/mini/my-stock")
        case .dividend:
            return URL(string: "http://127.0.0.1:3000/mini/dividend-list")
        case .profit:
            return URL(string: "http://127.0.0.1:3000/mini/my-profit")
        case .increase:
            return URL(string: "http://127.0.0.1:3000/mini/increase-list")
        }
    }
}
