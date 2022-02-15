//
//  StockListView.swift
//  TestApp
//
//  Created by iMac on 2022/01/28.
//

import UIKit

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
    
    private lazy var menuUnderBarView: UIView = {
        let view = UIView()
        view.backgroundColor = MenuColor.shared.mintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var separatorView: SeparatorView = {
        let separator = SeparatorView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StockListMainCollectionViewCell.self, forCellWithReuseIdentifier: StockListMainCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
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

extension StackListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockListMainCollectionViewCell.identifier, for: indexPath) as? StockListMainCollectionViewCell
        cell?.setup(menus: menus)
        return cell ?? UICollectionViewCell()
    }
    
}

extension StackListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

private extension StackListView {
    func addSubviews() {
        [menuCollectionView, separatorView, collectionView]
            .forEach {
                addSubview($0)
            }
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setLayoutConstraint() {
        menuCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        menuCollectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        separatorView.topAnchor.constraint(equalTo: menuCollectionView.bottomAnchor).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 730 + 16).isActive = true
    }
}
