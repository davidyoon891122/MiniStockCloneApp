//
//  StockListDetailViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/02/14.
//

import UIKit
import Kingfisher
import SnapKit

class StockListDetailViewCell: UICollectionViewCell {
    static let identifier = "StockListDetailViewCell"
    
    private lazy var stockImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "AT&T")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var firstHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        [stockNameLabel, stockPriceLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
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
        label.textAlignment = .right
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
        return stackView
    }()
    
    private lazy var stockQuantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0.075269주"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    private lazy var profitLabel: UILabel = {
        let label = UILabel()
        label.text = "396원"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .red
        return label
    }()
    
    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "+19.85%"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .red
        return label
    }()
    
    private lazy var detailVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        [firstHStackView, secondHStackView]
            .forEach {
                stackView.addArrangedSubview($0)
            }

        return stackView
    }()
    
    private let separatorView: SeparatorView = SeparatorView()
    
    func setup(stock: IncreaseStockModel) {
        addSubviews()
        setLayoutConstraints()
        stockNameLabel.text = stock.stockName
        stockQuantityLabel.text = stock.stockCode
        stockPriceLabel.text = stock.currentPrice.commaInString() + "원"
        percentageLabel.text = stock.percentChange.toStringWithFormat(format: 2) + "%"
        stockImageView.kf.setImage(with: URL(string: stock.imageURL ?? ""))
    }
}

private extension StockListDetailViewCell {
    func addSubviews() {
        [stockImageView, detailVStackView, separatorView]
            .forEach {
                contentView.addSubview($0)
            }
    }
    
    func setLayoutConstraints() {
        stockImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        detailVStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(stockImageView.snp.trailing).offset(5)
            $0.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
