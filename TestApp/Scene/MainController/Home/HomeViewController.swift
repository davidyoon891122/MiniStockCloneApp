//
//  HomeViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    private let networkManager = NetworkManager()
    
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
    
    private let investmentView = InvestmentView()

    private let myStockView = MyStockView()
    
    private let stockListView = StackListView()
    
    private let profitShareView = ProfitShareView()
    
    private let currencyView = CurrencyView()
    
    private let legalBoardView = LegalBoardView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.backgroundColor = MenuColor.shared.lightGrayColor
        
        investmentView.delegate = self
        myStockView.delegate = self
        myStockView.setDividendDelegate(viewController: self)
        legalBoardView.delegate = self
        stockListView.delegate = self
        
        [investmentView, myStockView, stockListView, profitShareView, currencyView, legalBoardView]
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
    
    override func viewWillAppear(_ animated: Bool) {
        networkManager.requestMyStock { [weak self] myStocks in
            
            self?.myStockView.setupData(myStocks: myStocks)
        }
        navigationController?.hidesBarsOnSwipe = true
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func moveToDetailStockView() {
        let detailStockVC = DetailStockViewController()
        navigationController?.pushViewController(detailStockVC, animated: true)
    }
    
    func upScrollAction() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            self?.scrollView.contentOffset.y = -100
        }, completion: nil)
    }
}

extension HomeViewController: InvestmentViewProtocol {
    func tapInvestmentBoardView() {
        tabBarController?.selectedIndex = 3
    }
    
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
        tabBarController?.selectedIndex = 3
    }
}
