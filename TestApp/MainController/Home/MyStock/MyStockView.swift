//
//  MyStockView.swift
//  TestApp
//
//  Created by iMac on 2022/01/21.
//

import UIKit

class MyStockView: UIView {
    
    private let tableViewCellId = "tableViewCellId"
    private var cellCount: Int = 2
    private lazy var titleHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        [titleLabel, sortingButton]
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
    
    private lazy var sortingButton: UIButton = {
        let button = UIButton()
        button.setTitle(MyStockSortingMenu.orderganada.text, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private lazy var dividendButton: UIButton = {
        let button = UIButton()
        button.setTitle("1개의 주식에서 배당이 나올 예정이에요 ⌵", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .lightGray
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellId, for: indexPath) as? MyStockViewTableCell
        guard let cell = cell else { return UITableViewCell() }
        
        return cell
    }
    
}

extension MyStockView: UITableViewDelegate {
    
}

private extension MyStockView {
    func addSubviews() {
        [myStockVStackView, stockTableView]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        myStockVStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        myStockVStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        myStockVStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        stockTableView.topAnchor.constraint(equalTo: myStockVStackView.bottomAnchor, constant: 5).isActive = true
        stockTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stockTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stockTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stockTableView.heightAnchor.constraint(equalToConstant: CGFloat(cellCount * 50)).isActive = true
    }
}
