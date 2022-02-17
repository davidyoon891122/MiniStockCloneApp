//
//  StockListMainCollectionViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/02/14.
//

import UIKit

class StockListMainCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "StockListMainCollectionViewCell"
    private var menus: [String]?
    private let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .black, .white, .systemPink, .gray]
    private let detailCellHeight: CGFloat = 65.0
    private lazy var sortingButtonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemBackground
        [sortingButton, etfButton]
            .forEach {
                stackView.addSubview($0)
            }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var sortingButton: UIButton = {
        let button = UIButton()
        button.setTitle("전일 기준 ⌵", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var etfButton: UIButton = {
        let button = UIButton()
        button.setTitle("⌾ ETF만 보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StockListDetailViewCell.self, forCellWithReuseIdentifier: StockListDetailViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setup(menus: [String]) {
        self.menus = menus
        addSubviews()
        setLayoutConstraints()
    }
}

extension StockListMainCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockListDetailViewCell.identifier, for: indexPath) as? StockListDetailViewCell
        
        cell?.setup()
        
        return cell ?? UICollectionViewCell()
    }
}

extension StockListMainCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: detailCellHeight)
    }
}

private extension StockListMainCollectionViewCell {
    func addSubviews() {
        [collectionView, moreButton, sortingButtonHStackView]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraints() {
        let inset: CGFloat = 16.0
        sortingButtonHStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        sortingButtonHStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset).isActive = true
        sortingButtonHStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset).isActive = true
        sortingButtonHStackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        sortingButton.centerYAnchor.constraint(equalTo: sortingButtonHStackView.centerYAnchor).isActive = true
        sortingButton.leadingAnchor.constraint(equalTo: sortingButtonHStackView.leadingAnchor).isActive = true
        
        etfButton.centerYAnchor.constraint(equalTo: sortingButtonHStackView.centerYAnchor).isActive = true
        etfButton.trailingAnchor.constraint(equalTo: sortingButtonHStackView.trailingAnchor).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: sortingButtonHStackView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        moreButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        moreButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset).isActive = true
        moreButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset).isActive = true
    }
}
