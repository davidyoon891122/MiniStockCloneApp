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
        homeViewController.tabBarItem = UITabBarItem(
            title: TabBarMenu.home.title,
            image: TabBarMenu.home.image,
            tag: 0
        
        )
        return UINavigationController(rootViewController: homeViewController)
    }()
    
    let searchViewController: UIViewController = {
        let searchViewController = UIViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: TabBarMenu.search.title,
            image: TabBarMenu.search.image,
            tag: 1
        )
        
        return searchViewController
    }()
    
    let themeViewController: UIViewController = {
        let themeViewController = UIViewController()
        themeViewController.tabBarItem = UITabBarItem(
            title: TabBarMenu.theme.title,
            image: TabBarMenu.theme.image,
            tag: 2
        
        )
        
        return themeViewController
    }()
    
    let assetViewController: UIViewController = {
        let assetViewController = UIViewController()
        assetViewController.tabBarItem = UITabBarItem(
            title: TabBarMenu.asset.title,
            image: TabBarMenu.asset.image,
            tag: 3
        )
        
        return assetViewController
    }()
    
    let settingsViewController: UIViewController = {
        let settingsViewController = UIViewController()
        settingsViewController.tabBarItem = UITabBarItem(
            title: TabBarMenu.settings.title,
            image: TabBarMenu.settings.image,
            tag: 4
        )
        
        return settingsViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.viewControllers = [
            homeViewController,
            searchViewController,
            themeViewController,
            assetViewController,
            settingsViewController
        ]
        
        self.tabBar.backgroundColor = .systemBackground
    }
}
