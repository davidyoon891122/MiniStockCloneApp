//
//  DividendCollectionViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/26.
//

import UIKit
import Kingfisher
import SnapKit

class DividendCollectionViewCell: UICollectionViewCell {
    private lazy var stockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12.5
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "AT&T")
        return imageView
    }()
    
    private lazy var stockNameLabel: UILabel = {
        let label = UILabel()
        label.text = "에이티앤티"
        label.textColor = .label
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    private lazy var dividendPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "연 0.50%"
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .medium)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "23,932원"
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1월 28일 배당락"
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .red
        return label
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(dividend: DividendModel) {
        stockImageView.kf.setImage(with: URL(string: dividend.imageURL ?? ""))
        stockNameLabel.text = dividend.stockName
        dividendPercentageLabel.text = "연 " + dividend.percentChange.toStringWithFormat(format: 2) + "%"
        priceLabel.text = dividend.currentPrice.commaInString()
        dateLabel.text = dividend.exDividendDate
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
        stockImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.height.equalTo(25)
            $0.width.equalTo(25)
        }
        
        stockNameLabel.snp.makeConstraints {
            $0.top.equalTo(stockImageView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(10)
        }
        
        dividendPercentageLabel.snp.makeConstraints {
            $0.top.equalTo(stockNameLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(dividendPercentageLabel.snp.bottom).offset(3)
            $0.leading.equalToSuperview().offset(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(10)
        }
    }
}
