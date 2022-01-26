//
//  MyStockViewTableCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/24.
//

import UIKit

class MyStockViewTableCell: UITableViewCell {
    
    private lazy var stockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 20
        
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var firstHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        [stockNameLabel, stockPriceLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stockNameLabel: UILabel = {
        let label = UILabel()
        label.text = "AT&T"
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var stockPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "2,390원"
        label.textColor = .label
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var secondHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        let innerStackView = UIStackView()
        innerStackView.axis = .horizontal
        innerStackView.spacing = 10
        [profitLabel, percentageLabel]
            .forEach {
                innerStackView.addArrangedSubview($0)
            }
    
        [stockQuantityLabel, innerStackView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stockQuantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0.075269주"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private lazy var profitLabel: UILabel = {
        let label = UILabel()
        label.text = "396원"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "+19.85%"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setLayoutConstraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MyStockViewTableCell {
    func addSubviews() {
        [stockImageView, firstHStackView, secondHStackView]
            .forEach {
                contentView.addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        stockImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stockImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stockImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        stockImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        firstHStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        firstHStackView.leadingAnchor.constraint(equalTo: stockImageView.trailingAnchor, constant: 5).isActive = true
        firstHStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        firstHStackView.bottomAnchor.constraint(equalTo: secondHStackView.topAnchor).isActive = true
        
        secondHStackView.topAnchor.constraint(equalTo: firstHStackView.bottomAnchor).isActive = true
        secondHStackView.leadingAnchor.constraint(equalTo: stockImageView.trailingAnchor, constant: 5).isActive = true
        secondHStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        secondHStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
