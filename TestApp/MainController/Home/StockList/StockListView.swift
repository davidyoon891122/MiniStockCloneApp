//
//  StockListView.swift
//  TestApp
//
//  Created by iMac on 2022/01/28.
//

import UIKit

class StackListView: UIView {
    private let menuCellId = "menuCellId"
    private let menus: [String] = [
        "상승",
        "하락",
        "배당",
        "조회급등",
        "인기검색",
        "시가총액"
    ]
    
    private lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 30
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: menuCellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: menuCellId, for: indexPath) as? MenuCollectionViewCell
        cell?.setup(title: menus[indexPath.row])
        
        if indexPath.row == 0 {
            cell?.selectedAction()
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        return cell ?? UICollectionViewCell()
    }
    
}

extension StackListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = menus[indexPath.row]
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell
        selectedCell?.selectedAction()

    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as? MenuCollectionViewCell
        selectedCell?.deselectAction()
    }
}

private extension StackListView {
    func addSubviews() {
        [menuCollectionView, separatorView, sortingButtonHStackView]
            .forEach {
                addSubview($0)
            }
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
        
        sortingButtonHStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        sortingButtonHStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        sortingButtonHStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        sortingButtonHStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        sortingButton.leadingAnchor.constraint(equalTo: sortingButtonHStackView.leadingAnchor, constant: 20).isActive = true
        sortingButton.centerYAnchor.constraint(equalTo: sortingButtonHStackView.centerYAnchor).isActive = true
        
        etfButton.trailingAnchor.constraint(equalTo: sortingButtonHStackView.trailingAnchor, constant: -20).isActive = true
        etfButton.centerYAnchor.constraint(equalTo: sortingButtonHStackView.centerYAnchor).isActive = true
    }
}
