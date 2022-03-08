//
//  StockListMainCollectionViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/02/14.
//

import UIKit
import SnapKit

class StockListMainCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "StockListMainCollectionViewCell"
    private var menus: [String]?
    private let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .purple, .black, .white, .systemPink, .gray]
    private let detailCellHeight: CGFloat = 65.0
    private var increasedStocks: [IncreaseStockModel] = []
    weak var delegate: HomeViewProtocol?
    
    private lazy var sortingButtonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemBackground
        [sortingButton, etfButton]
            .forEach {
                stackView.addSubview($0)
            }
        return stackView
    }()
    
    private lazy var sortingButton: UIButton = {
        let button = UIButton()
        button.setTitle("전일 기준 ⌵", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    
    private lazy var etfButton: UIButton = {
        let button = UIButton()
        button.setTitle("⌾ ETF만 보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(.lightGray, for: .normal)
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
        collectionView.register(
            StockListDetailViewCell.self,
            forCellWithReuseIdentifier: StockListDetailViewCell.identifier
        )
        
        return collectionView
    }()
    
    private let tableView: UITableView = UITableView()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        return button
    }()
    
    private let viewModel = StockListMainCollectionViewModel()
    
    func setup(menus: [String]) {
        self.menus = menus
        addSubviews()
        setLayoutConstraints()
        
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.increasedStocks = self.viewModel.inscreaseStocks
            self.collectionView.reloadData()
        }
        
        viewModel.fetchIncreaseList()
    }
}

extension StockListMainCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return increasedStocks.count
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StockListDetailViewCell.identifier,
            for: indexPath
        ) as? StockListDetailViewCell
        let stock = increasedStocks[indexPath.row]
        cell?.setup(stock: stock)
        
        return cell ?? UICollectionViewCell()
    }
}

extension StockListMainCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: detailCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.moveToDetailStockView()
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
        
        sortingButtonHStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(30)
        }
        
        sortingButton.snp.makeConstraints {
            $0.centerY.equalTo(sortingButtonHStackView)
            $0.leading.equalTo(sortingButtonHStackView)
        }
        
        etfButton.snp.makeConstraints {
            $0.centerY.equalTo(sortingButtonHStackView)
            $0.trailing.equalTo(sortingButtonHStackView)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(sortingButtonHStackView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.leading.equalToSuperview().offset(inset)
            $0.height.equalTo(50)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
        }
    }
}
