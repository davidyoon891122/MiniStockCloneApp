//
//  DetailStockViewController.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import UIKit

class DetailStockViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        view.backgroundColor = .systemBackground
    }
}

private extension DetailStockViewController {
    func configureNavigation() {
        navigationItem.title = "StockName"
        navigationController?.isNavigationBarHidden = false
    }
}
