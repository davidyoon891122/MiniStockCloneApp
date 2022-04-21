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
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/my-stock")
        case .dividend:
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/dividend-list")
        case .profit:
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/my-profit")
        case .increase:
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/increase-list")
        }
    }
}
