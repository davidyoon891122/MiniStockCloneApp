//
//  HomeViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit

class HomeViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.backgroundColor = .lightGray
        
        let firstView = InvestmentView()
        
        let secondView = MyStockView()
        
        let thirdView = UIView()
        thirdView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        thirdView.backgroundColor = .yellow
        
        [firstView, secondView, thirdView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
        addSubviews()
        setLayoutConstraint()
        
    }
}

private extension HomeViewController {
    func configureNavigation() {
        let shareNavigationBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(tapShareButton))
        
        let bagNavigationBarButton = UIBarButtonItem(image: UIImage(systemName: "bag"), style: .plain, target: self, action: #selector(tapBagButton))
        
        navigationItem.rightBarButtonItems = [shareNavigationBarButton, bagNavigationBarButton]
        
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func setLayoutConstraint() {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    }
    
    @objc func tapShareButton() {
        print("Share Button tapped...")
    }
    
    @objc func tapBagButton() {
        print("Bag Button tapped...")
    }
}
