//
//  DividendCollectionViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/26.
//

import UIKit

class DividendCollectionViewCell: UICollectionViewCell {
    private lazy var stockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12.5
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "AT&T")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stockNameLabel: UILabel = {
        let label = UILabel()
        label.text = "에이티앤티"
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dividendPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "연 0.50%"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "23,932원"
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1월 28일 배당락"
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DividendCollectionViewCell {
    func addSubviews() {
        [stockImageView, stockNameLabel, dividendPercentageLabel, priceLabel, dateLabel]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        stockImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        stockImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stockImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        stockImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        stockNameLabel.topAnchor.constraint(equalTo: stockImageView.bottomAnchor, constant: 5).isActive = true
        stockNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        dividendPercentageLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 10).isActive = true
        dividendPercentageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: dividendPercentageLabel.bottomAnchor, constant: 3).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 13).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
    }
}
