//
//  URLInfo.swift
//  TestApp
//
//  Created by iMac on 2022/04/20.
//

import Foundation

enum URLInfo {
    case stock

    var url: URL? {
        switch self {
        case .stock:
            return URL(string: "https://boiling-scrubland-57180.herokuapp.com/my-stock")
        }
    }
}
