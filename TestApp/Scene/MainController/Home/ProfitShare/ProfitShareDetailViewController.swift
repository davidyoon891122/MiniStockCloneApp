//
//  ProfitShareDetailViewController.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import Foundation
import UIKit

class ProfitShareDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        view.backgroundColor = .systemBackground
    }
}

private extension ProfitShareDetailViewController {
    func configureNavigation() {
        navigationItem.title = "ProfitShareDetail"
        navigationController?.isNavigationBarHidden = false
        
    }
}
