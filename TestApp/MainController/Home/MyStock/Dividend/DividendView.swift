//
//  DividendView.swift
//  TestApp
//
//  Created by iMac on 2022/01/26.
//

import UIKit

class DividendView: UIView {
    
    private let collectionViewCellId = "cellId"
    
    private lazy var labelVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        [labelHStack, titleLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var labelHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        [descriptionLabel, dividendBaseLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "은행 이자 부럽지 않은 배당"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var dividendBaseLabel: UILabel = {
        let label = UILabel()
        label.text = "미국 배당락일 기준 ⍰"
        label.textAlignment = .right
        
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 사면 배당받는 주식!"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var stockCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = MenuColor.shared.mintColor
        collectionView.register(DividendCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = MenuColor.shared.mintColor
        addSubviews()
        setLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DividendView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as? DividendCollectionViewCell
        return cell ?? UICollectionViewCell()
    }
}

extension DividendView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3 - 20, height: 150.0)
    }
}

private extension DividendView {
    func addSubviews() {
        [labelVStack, stockCollectionView]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        labelVStack.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        labelVStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        labelVStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        stockCollectionView.topAnchor.constraint(equalTo: labelVStack.bottomAnchor, constant: 10).isActive = true
        stockCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stockCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        stockCollectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        stockCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
