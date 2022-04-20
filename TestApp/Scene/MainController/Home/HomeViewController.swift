//
//  HomeViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit
import SnapKit
import RxSwift

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    private let networkManager = NetworkManager()
    private let blackView = UIView()
    private let currencyDetailView = CurrencyDetailView()
    private let sortingSelectView = SortingSelectView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(pullScrollForRefresh), for: .valueChanged)
        return control
    }()
    
    private let contentView: UIView = UIView()
    
    private let indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
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
        
        [
            investmentView,
            myStockView,
            stockListView,
            profitShareView,
            currencyView,
            legalBoardView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
        addSubviews()
        setLayoutConstraint()
        scrollView.refreshControl = refreshControl
        
        indicatorView.startAnimating()

        requestFetchData()

        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.myStockView.setupViewModel(viewModel: self.viewModel)
            self.investmentView.setupData(profit: self.viewModel.profit)
            self.myStockView.setupDividendData(dividends: self.viewModel.dividends)
            self.indicatorView.stopAnimating()
        }
        
        viewModel.fetchMyStock()
        viewModel.fetchProfit()
        viewModel.fetchDividendList()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func upScrollAction() {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: { [weak self] in
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
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
            self.blackView.alpha = 1
            self.currencyDetailView.frame = CGRect(
                x: 0,
                y: currencyDetailViewYOffset,
                width: window.frame.width,
                height: height
            )
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
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
            self.blackView.alpha = 1
            self.sortingSelectView.frame = CGRect(
                x: 0,
                y: currencyDetailViewYOffset,
                width: window.frame.width,
                height: height
            )
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
        let shareNavigationBarButton = UIBarButtonItem(
            image: HomeViewNavigationMenu.share.imageName,
            style: .plain,
            target: self,
            action: #selector(tapShareButton)
        )
        shareNavigationBarButton.tintColor = .label
        let bagNavigationBarButton = UIBarButtonItem(
            image: HomeViewNavigationMenu.bag.imageName,
            style: .plain,
            target: self,
            action: #selector(tapBagButton)
        )
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
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
            self.blackView.alpha = 0
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
            
            self.currencyDetailView.frame = CGRect(
                x: 0,
                y: window.frame.height,
                width: self.currencyDetailView.frame.width,
                height: self.currencyDetailView.frame.height
            )
            
            self.sortingSelectView.frame = CGRect(
                x: 0,
                y: window.frame.height,
                width: self.sortingSelectView.frame.width,
                height: self.sortingSelectView.frame.height
            )
        }, completion: nil)
    }
    
    @objc func pullScrollForRefresh() {
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }

            self.investmentView.setupData(profit: self.viewModel.profit)
            self.myStockView.setupDividendData(dividends: self.viewModel.dividends)
            self.refreshControl.endRefreshing()
        }
        
        viewModel.fetchMyStock()
        viewModel.fetchProfit()
        viewModel.fetchDividendList()
        
    }

    func requestFetchData() {
        viewModel.fetchMyStock()
    }
}
