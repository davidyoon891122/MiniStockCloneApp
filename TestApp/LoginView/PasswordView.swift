//
//  PasswordView.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit

class PasswordView:UIView {
    
    private let cellId = "cellId"
    
    private lazy var topDragBar: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, descriptionLabel]
            .forEach{
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "간편비밀번호"
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "6자리를 입력해 주세요"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    
    private lazy var numberButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var firstRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .red
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var secondRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .orange
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var thirdRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .yellow
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var fourthRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .green
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var numberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.masksToBounds = true
        addSubviews()
        setLayoutConstraint()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PasswordView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .gray
        return cell
    }
    
    
}

extension PasswordView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: 80)
    }
}



private extension PasswordView {
    func addSubviews() {
        [topDragBar, labelStackView, numberCollectionView]
            .forEach{
                addSubview($0)
            }
        
    }
    
    
    func setLayoutConstraint() {
        topDragBar.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        topDragBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topDragBar.widthAnchor.constraint(equalToConstant: 70).isActive = true
        topDragBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        labelStackView.topAnchor.constraint(equalTo: topDragBar.bottomAnchor, constant: 50).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        
//        numberCollectionView.heightAnchor.constraint(equalToConstant: 320).isActive = true
//        numberCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
//        numberCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        numberCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
}
