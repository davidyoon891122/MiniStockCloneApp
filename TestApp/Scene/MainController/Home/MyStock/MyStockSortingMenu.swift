//
//  MyStockSortingMenu.swift
//  TestApp
//
//  Created by iMac on 2022/01/21.
//

import Foundation

enum MyStockSortingMenu {
    case orderPrice
    case orderganada
    case orderHigh
    case orderlow
    
    var text: String {
        switch self {
            
        case .orderPrice:
            return "평가금액순 ▾"
        case .orderganada:
            return "가나다순 ▾"
        case .orderHigh:
            return "수익률 높은순 ▾"
        case .orderlow:
            return "수익률 낮은순 ▾"
        }
    }
    
    var detailText: String {
        switch self {
        case .orderPrice:
            return "평가금액순"
        case .orderganada:
            return "가나다순"
        case .orderHigh:
            return "수익률 높은순"
        case .orderlow:
            return "수익률 낮은순"
        }
    }
}
