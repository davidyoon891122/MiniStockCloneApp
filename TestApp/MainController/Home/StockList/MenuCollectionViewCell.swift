//
//  MenuCollectionViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/28.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var menuBar: UIView = {
        let view = UIView()
        view.backgroundColor = MenuColor.shared.mintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        self.titleLabel.text = title
    }
    
    func selectedAction() {
        titleLabel.textColor = MenuColor.shared.mintColor
        addSubview(menuBar)
        
        menuBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func deselectAction() {
        menuBar.removeFromSuperview()
        titleLabel.textColor = .label
    }
    
}

private extension MenuCollectionViewCell {
    func addSubviews() {
        [titleLabel]
            .forEach {
                contentView.addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
