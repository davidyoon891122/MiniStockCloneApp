//
//  Extension+.swift
//  TestApp
//
//  Created by iMac on 2022/02/23.
//

import Foundation

extension Int {
    func commaInString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter.string(from: self as NSNumber)!
    }
}
