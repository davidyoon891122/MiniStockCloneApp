//
//  TabBarMenu.swift
//  TestApp
//
//  Created by iMac on 2022/01/21.
//

import Foundation
import UIKit

enum TabBarMenu {
    case home
    case search
    case theme
    case asset
    case settings
    
    var image: UIImage {
        switch self {
        case .home:
            return UIImage(systemName: "house") ?? UIImage()
        case .search:
            return UIImage(systemName: "magnifyingglass") ?? UIImage()
        case .theme:
            return UIImage(systemName: "chart.xyaxis.line") ?? UIImage()
        case .asset:
            return UIImage(systemName: "bitcoinsign.square.fill") ?? UIImage()
        case .settings:
            return UIImage(systemName: "gearshape") ?? UIImage()
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .theme:
            return "Theme"
        case .asset:
            return "Asset"
        case .settings:
            return "Settings"
        }
    }
    
}
