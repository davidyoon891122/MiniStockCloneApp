//
//  StockListView.swift
//  TestApp
//
//  Created by iMac on 2022/01/28.
//

import UIKit
import SnapKit

class StackListView: UIView {
    private let menus: [String] = [
        "상승",
        "하락",
        "배당",
        "조회급등",
        "인기검색",
        "시가총액"
    ]
    
    private lazy var menuCollectionView = StockListMenuCollectionView(menus: self.menus)
    weak var delegate: HomeViewProtocol?
    private lazy var menuUnderBarView: UIView = {
        let view = UIView()
        view.backgroundColor = MenuColor.shared.mintColor
        return view
    }()
    
    private let separatorView: SeparatorView = SeparatorView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            StockListMainCollectionViewCell.self,
            forCellWithReuseIdentifier: StockListMainCollectionViewCell.identifier
        )
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
        backgroundColor = .systemBackground
        menuCollectionView.menuDelegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension StackListView: StockListViewProtocol {
    func selectMenu(indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .right)
    }
    
}

extension StackListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: StockListMainCollectionViewCell.identifier,
            for: indexPath
        ) as? StockListMainCollectionViewCell
        cell?.setup(menus: menus)
        
        cell?.delegate = delegate
        return cell ?? UICollectionViewCell()
    }
    
}

extension StackListView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = collectionView.contentOffset.x / frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuCollectionView.moveMenuWithStockListMainCollectionView(indexPath: indexPath)
    }
}

private extension StackListView {
    func addSubviews() {
        [menuCollectionView, separatorView, collectionView]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        menuCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(menuCollectionView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(746)
        }
    }
}
