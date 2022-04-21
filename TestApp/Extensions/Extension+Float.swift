//
//  Extension+Float.swift
//  TestApp
//
//  Created by iMac on 2022/04/20.
//

import Foundation

extension Float {
    func toStringWithFormat(format: Int) -> String {
        return String(format: "%.\(format)f", self)
    }
}
