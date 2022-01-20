//
//  HomeViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit

class HomeViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
        
    }
}


private extension HomeViewController {
    func configureNavigation() {
        navigationItem.title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    func addSubviews() {
        
    }
    
    func setLayoutConstraint() {
        
    }
}
