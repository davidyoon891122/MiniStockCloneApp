//
//  PasswordNumberCollectionViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/18.
//

import UIKit

class PasswordNumberCollectionViewCell: UICollectionViewCell {
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.separator.cgColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


private extension PasswordNumberCollectionViewCell {
    func addSubviews() {
        contentView.addSubview(numberLabel)
    }
    
    func setLayoutConstraint() {
        numberLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
