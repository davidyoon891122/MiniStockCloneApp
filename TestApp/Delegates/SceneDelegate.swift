//
//  SceneDelegate.swift
//  TestApp
//
//  Created by iMac on 2022/01/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let switchMenu = SwitchMenu.real

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        var rootViewController: UIViewController
        window = UIWindow(windowScene: windowScene)
        window?.backgroundColor = .systemBackground
        switch switchMenu {
        case .real:
            rootViewController = LoginViewController()
        case .test:
            rootViewController = HomeTabBarController()
        }
        window?.rootViewController = rootViewController
        
        UINavigationBar.appearance().prefersLargeTitles = false
        window?.makeKeyAndVisible()
        
    }
}
