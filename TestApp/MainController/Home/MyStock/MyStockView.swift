//
//  MyStockView.swift
//  TestApp
//
//  Created by iMac on 2022/01/21.
//

import UIKit

class MyStockView: UIView {
    
    private let tableViewCellId = "tableViewCellId"
    private var cellCount: Int = 1
    
    private let dividendView = DividendView()
    
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
        label.translatesAutoresizingMaskIntoConstraints = false
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
        button.setTitle(MyStockSortingMenu.orderganada.text, for: .normal)
        button.setTitleColor(.gray, for: .normal)
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var stockTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MyStockViewTableCell.self, forCellReuseIdentifier: tableViewCellId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
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
}

extension MyStockView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as? MyStockViewTableCell
        guard let cell = cell else { return UITableViewCell() }
        return cell
    }
    
}

extension MyStockView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
        myStockVStackView.topAnchor.constraint(equalTo: topAnchor, constant: inset).isActive = true
        myStockVStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset).isActive = true
        myStockVStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset).isActive = true
        
        stockTableView.topAnchor.constraint(equalTo: myStockVStackView.bottomAnchor, constant: inset).isActive = true
        stockTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset).isActive = true
        stockTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset).isActive = true
        stockTableView.heightAnchor.constraint(equalToConstant: CGFloat(cellCount * 50)).isActive = true
        
        dividendView.translatesAutoresizingMaskIntoConstraints = false
        dividendView.topAnchor.constraint(equalTo: stockTableView.bottomAnchor, constant: inset).isActive = true
        dividendView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dividendView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dividendView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
}
