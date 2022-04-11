//
//  TabBarItem.swift
//  TestApp
//
//  Created by iMac on 2022/04/11.
//

import Foundation
import UIKit

enum TabBarItem: CaseIterable {
    case home
    case search
    case theme
    case asset
    case settings

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

    var icon: (default: UIImage?, selected: UIImage?) {
        switch self {
        case .home:
            return (
                UIImage(systemName: "house"),
                UIImage(systemName: "house.fill")
            )
        case .search:
            return (
                UIImage(systemName: "magnifyingglass.circle"),
                UIImage(systemName: "magnifyingglass.circle.fill")
            )
        case .theme:
            return (
                UIImage(systemName: "chart.line.uptrend.xyaxis.circle"),
                UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
            )
        case .asset:
            return (
                UIImage(systemName: "bitcoinsign.square"),
                UIImage(systemName: "bitcoinsign.square.fill")
            )
        case .settings:
            return (
                UIImage(systemName: "gearshape"),
                UIImage(systemName: "gearshape.fill")
            )
        }
    }

    var viewController: UIViewController {
        switch self {
        case .home:
            return UINavigationController(rootViewController: HomeViewController())
        case .search:
            return UIViewController()
        case .theme:
            return UIViewController()
        case .asset:
            return UIViewController()
        case .settings:
            return UIViewController()
        }
    }
}
