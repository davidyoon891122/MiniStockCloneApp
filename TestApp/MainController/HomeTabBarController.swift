//
//  HomeTabBarViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/20.
//

import UIKit

class HomeTabBarController: UITabBarController {
    let homeViewController: UIViewController = {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return UINavigationController(rootViewController: homeViewController)
    }()
    let searchViewController: UIViewController = {
        let searchViewController = UIViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        return searchViewController
    }()
    let themeViewController: UIViewController = {
        let themeViewController = UIViewController()
        themeViewController.tabBarItem = UITabBarItem(title: "Theme", image: UIImage(systemName: "chart.xyaxis.line"), tag: 2)
        return themeViewController
    }()
    let assetViewController: UIViewController = {
        let assetViewController = UIViewController()
        assetViewController.tabBarItem = UITabBarItem(title: "Asset", image: UIImage(systemName: "bitcoinsign.square.fill"), tag: 3)
        return assetViewController
    }()
    let settingsViewController: UIViewController = {
        let settingsViewController = UIViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), tag: 4)
        return settingsViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.viewControllers = [homeViewController, searchViewController, themeViewController, assetViewController, settingsViewController]
        
        self.tabBar.backgroundColor = .systemBackground
    }
}
