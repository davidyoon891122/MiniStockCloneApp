//
//  TestSettings.swift
//  TestApp
//
//  Created by iMac on 2022/01/26.
//

import Foundation

enum SwitchMenu {
    case real
    case test
    
    var isTest: Bool {
        switch self {
        case .real:
            return false
        case .test:
            return true
        }
    }
}
