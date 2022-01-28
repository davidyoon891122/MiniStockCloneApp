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
        stackView.backgroundColor = MenuColor.shared.lightGrayColor
        
        let investmentView = InvestmentView()
        investmentView.delegate = self
        let myStockView = MyStockView()
        
        let thirdView = UIView()
        thirdView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        thirdView.backgroundColor = .yellow
        
        [investmentView, myStockView, thirdView]
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

extension HomeViewController: InvestmentViewProtocol {
    func tapNoticeTableViewCell() {
        let detailNoticeViewController = DetailNoticeViewController()
        navigationController?.pushViewController(detailNoticeViewController, animated: true)
    }
}

private extension HomeViewController {
    func configureNavigation() {
        let shareNavigationBarButton = UIBarButtonItem(image: HomeViewNavigationMenu.share.imageName, style: .plain, target: self, action: #selector(tapShareButton))
        shareNavigationBarButton.tintColor = .label
        let bagNavigationBarButton = UIBarButtonItem(image: HomeViewNavigationMenu.bag.imageName, style: .plain, target: self, action: #selector(tapBagButton))
        bagNavigationBarButton.tintColor = .label
        navigationItem.rightBarButtonItems =  [bagNavigationBarButton, shareNavigationBarButton]
        
        navigationController?.hidesBarsOnSwipe = true
        
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func setLayoutConstraint() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
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
    
    @objc func tapInvestmentView() {
        print("Investment View tapped...")
    }
}
