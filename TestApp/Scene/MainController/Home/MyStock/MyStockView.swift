//
//  MyStockView.swift
//  TestApp
//
//  Created by iMac on 2022/01/21.
//

import UIKit
import SnapKit

class MyStockView: UIView {
    private var cellCount: Int = 1
    private let dividendView = DividendView()
    
    private var sortingMenu: MyStockSortingMenu = .orderganada
    
    private var myStocks: [MyStockModel] = []
    
    private let cellHeight: CGFloat = 60.0
    
    weak var delegate: HomeViewProtocol?
    
    private lazy var titleHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        
        stackView.axis = .horizontal
        sortingButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        [titleLabel, sortingButtonHStack]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "보유 주식"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    private lazy var sortingButtonHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(sortingButton)
        return stackView
    }()
    
    private lazy var sortingButton: UIButton = {
        let button = UIButton()
        button.setTitle(sortingMenu.text, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(tapSortingButton), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    private lazy var dividendButton: UIButton = {
        let button = UIButton()
        button.setTitle("1개의 주식에서 배당이 나올 예정이에요 ⌵", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = MenuColor.shared.lightGrayColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var myStockVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        dividendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        [titleHStackView, dividendButton]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var stockTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyStockViewTableCell.self, forCellReuseIdentifier: MyStockViewTableCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88.0
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(myStocks: [MyStockModel]) {
        self.myStocks = myStocks
        self.cellCount = myStocks.count
        
        stockTableView.snp.updateConstraints {
            $0.height.equalTo(CGFloat(cellCount) * cellHeight)
        }
        
        stockTableView.reloadData()
    }
    
    func setupDividendData(dividends: [DividendModel]) {
        self.dividendView.setupData(dividends: dividends)
    }
    
    func setDividendDelegate(viewController: HomeViewProtocol) {
        dividendView.delegate = viewController
    }
    
    func setSortingMenu(menu: MyStockSortingMenu) {
        sortingMenu = menu
        sortingButton.setTitle(sortingMenu.text, for: .normal)
        
    }
    
    func getCurrentSortingMenu() -> MyStockSortingMenu {
        return sortingMenu
    }
}

extension MyStockView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyStockViewTableCell.identifier, for: indexPath) as? MyStockViewTableCell
        let stock = self.myStocks[indexPath.row]
        cell?.setup(myStock: stock)
        
        return cell ?? UITableViewCell()
    }
    
}

extension MyStockView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.moveToDetailStockView()
    }
}

private extension MyStockView {
    func addSubviews() {
        [myStockVStackView, stockTableView, dividendView]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        let inset: CGFloat = 16.0
        
        myStockVStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        stockTableView.snp.makeConstraints {
            $0.top.equalTo(myStockVStackView.snp.bottom).offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(CGFloat(cellCount) * cellHeight)
        }
        
        dividendView.snp.makeConstraints {
            $0.top.equalTo(stockTableView.snp.bottom).offset(inset)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
    @objc func tapSortingButton() {
        print("did tap sortingButton.")
        delegate?.openSortingButtonView()
    }
}
