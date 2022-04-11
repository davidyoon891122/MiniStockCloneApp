//
//  HomeTabBarViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/20.
//

import UIKit

class HomeTabBarController: UITabBarController {
    private lazy var tabViewControllers: [UIViewController] = TabBarItem.allCases
        .map { menu in
            let viewController = menu.viewController
            viewController.tabBarItem = UITabBarItem(
                title: menu.title,
                image: menu.icon.default,
                selectedImage: menu.icon.selected
            )
            return viewController
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        viewControllers = tabViewControllers
        self.tabBar.backgroundColor = .systemBackground
    }
}
