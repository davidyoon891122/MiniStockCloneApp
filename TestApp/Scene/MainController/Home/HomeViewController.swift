//
//  HomeViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    private let networkManager = NetworkManager()
    private let blackView = UIView()
    private let currencyDetailView = CurrencyDetailView()
    private let sortingSelectView = SortingSelectView()
    
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
    
    private lazy var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
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
        
        setDelegate()
        
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
        
        indicatorView.startAnimating()
        networkManager.requestMyStock { [weak self] myStocks in

            self?.myStockView.setupData(myStocks: myStocks)
        }
        
        networkManager.requestProfit { [weak self] myProfit in
            self?.investmentView.setupData(profit: myProfit)
        }
        
        networkManager.requestDividendList {[weak self] dividends in
            self?.myStockView.setupDividendData(dividends: dividends)
            self?.indicatorView.stopAnimating()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func upScrollAction() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: { [weak self] in
            self?.scrollView.contentOffset.y = -50
        }, completion: nil)
    }
    
    func moveToDetailStockView() {
        let detailStockVC = DetailStockViewController()
        navigationController?.pushViewController(detailStockVC, animated: true)
    }
    
    func moveToProfitShareDetailView() {
        let profitShareDetailVC = ProfitShareDetailViewController()
        navigationController?.pushViewController(profitShareDetailVC, animated: true)
    }
    
    func openCurrenyDetailView() {
        blackView.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        
        blackView.frame = window.frame
        blackView.alpha = 0
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBlackView)))
        
        [blackView, currencyDetailView]
            .forEach {
                window.addSubview($0)
            }
        let height: CGFloat = 500
        let currencyDetailViewYOffset = window.frame.height - height
        
        currencyDetailView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 1
            self.currencyDetailView.frame = CGRect(x: 0, y: currencyDetailViewYOffset, width: window.frame.width, height: height)
        }, completion: nil)
    }
    
    func closeCurrenyDetailView() {
        tapBlackView()
    }
    
    func openSortingButtonView() {
        blackView.backgroundColor = UIColor(white: 0.2, alpha: 0.8)
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        
        blackView.frame = window.frame
        blackView.alpha = 0
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBlackView)))
        
        let currentMenu = myStockView.getCurrentSortingMenu()
        sortingSelectView.setCurrentSortingMenu(menu: currentMenu)
        
        [blackView, sortingSelectView]
            .forEach {
                window.addSubview($0)
            }
        let height: CGFloat = 250
        let currencyDetailViewYOffset = window.frame.height - height
        
        sortingSelectView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 1
            self.sortingSelectView.frame = CGRect(x: 0, y: currencyDetailViewYOffset, width: window.frame.width, height: height)
        }, completion: nil)
    }
    
    func sortingButtonSelected(menu: MyStockSortingMenu) {
        myStockView.setSortingMenu(menu: menu)
        tapBlackView()
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
        [scrollView, indicatorView]
            .forEach {
                view.addSubview($0)
            }
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func setLayoutConstraint() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
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
        tabBarController?.selectedIndex = 3
    }
    
    func setDelegate() {
        investmentView.delegate = self
        myStockView.delegate = self
        myStockView.setDividendDelegate(viewController: self)
        legalBoardView.delegate = self
        stockListView.delegate = self
        profitShareView.delegate = self
        currencyView.delegate = self
        currencyDetailView.delegate = self
        sortingSelectView.delegate = self
    }
    
    @objc func tapBlackView() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.blackView.alpha = 0
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
            
            self.currencyDetailView.frame = CGRect(x: 0, y: window.frame.height, width: self.currencyDetailView.frame.width, height: self.currencyDetailView.frame.height)
            
            self.sortingSelectView.frame = CGRect(x: 0, y: window.frame.height, width: self.sortingSelectView.frame.width, height: self.sortingSelectView.frame.height)
        }, completion: nil)
    }
}
