//
//  MenuColor.swift
//  TestApp
//
//  Created by iMac on 2022/01/27.
//

import Foundation
import UIKit

struct MenuColor {
    static var shared = MenuColor()
    
    var mintColor: UIColor {
        return UIColor(red: 35/255, green: 204/255, blue: 216/255, alpha: 1)
    }
    
    var lightGrayColor: UIColor {
        return UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
    }
}
