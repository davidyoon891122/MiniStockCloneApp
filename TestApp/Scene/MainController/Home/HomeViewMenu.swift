//
//  HomeViewMenu.swift
//  TestApp
//
//  Created by iMac on 2022/01/27.
//

import UIKit

enum HomeViewNavigationMenu {
    case share
    case bag
    
    var imageName: UIImage {
        switch self {
            
        case .share:
            return UIImage(systemName: "square.and.arrow.up") ?? UIImage()
        case .bag:
            return UIImage(systemName: "bag") ?? UIImage()
        }
    }
}
