//
//  MyStockViewTableCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/24.
//

import UIKit
import Kingfisher
import SnapKit

class MyStockViewTableCell: UITableViewCell {
    static let identifier: String = "MyStockViewTableCell"
    
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
        
        [
            stockNameLabel,
            stockPriceLabel
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var stockNameLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .label
        label.font = .systemFont(
            ofSize: 20,
            weight: .bold
        )
        return label
    }()
    
    private lazy var stockPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "-- 원"
        label.textColor = .label
        label.textAlignment = .right
        label.font = .systemFont(
            ofSize: 18,
            weight: .bold
        )
        return label
    }()
    
    private lazy var secondHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        let innerStackView = UIStackView()
        innerStackView.axis = .horizontal
        innerStackView.spacing = 10
        [
            profitLabel,
            percentageLabel
        ]
            .forEach {
                innerStackView.addArrangedSubview($0)
            }
    
        [
            stockQuantityLabel,
            innerStackView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }

        return stackView
    }()
    
    private lazy var stockQuantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0 주"
        label.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        label.textColor = .label
        return label
    }()
    
    private lazy var profitLabel: UILabel = {
        let label = UILabel()
        label.text = "-- 원"
        label.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        label.textColor = .red
        return label
    }()
    
    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "--.-- %"
        label.font = .systemFont(
            ofSize: 15,
            weight: .medium
        )
        label.textColor = .red
        return label
    }()
    
    private lazy var stockVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        [
            firstHStackView,
            secondHStackView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setLayoutConstraint()
        selectionStyle = .none

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(myStock: MyStockModel) {
        stockNameLabel.text = "\(myStock.stockName)"
        stockPriceLabel.text = myStock.currentPrice.commaInString() + "원"
        stockQuantityLabel.text = "\(myStock.stockQuantity) 주"
        profitLabel.text = myStock.valueChange.commaInString() + " 원"
        percentageLabel.text = myStock.percentChange.toStringWithFormat(format: 2) + " %"
        stockImageView.kf.setImage(with: URL(string: myStock.imageURL ?? ""))
    }
    
}

private extension MyStockViewTableCell {
    func addSubviews() {
        [stockImageView, stockVStackView]
            .forEach {
                contentView.addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        stockImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
        
        stockVStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(stockImageView.snp.trailing).offset(5)
            $0.trailing.equalToSuperview()
        }
    }
    
}
