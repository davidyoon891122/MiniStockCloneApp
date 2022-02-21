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
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "AT&T")
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
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .bold)
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
    
    private lazy var stockVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        [firstHStackView, secondHStackView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
    
    func setup(myStock: MyStock) {
        stockNameLabel.text = "\(myStock.stockName)"
        stockPriceLabel.text = "\(commaInString(price: myStock.currentPrice))원"
        stockQuantityLabel.text = "\(myStock.stockQuantity)주"
        profitLabel.text = "\(commaInString(price: myStock.valueChange))원"
        percentageLabel.text = String(format: "%.2f", myStock.percentChange) + "%"
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
        stockImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stockImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stockImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        stockImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stockVStackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stockVStackView.leadingAnchor.constraint(equalTo: stockImageView.trailingAnchor, constant: 5).isActive = true
        stockVStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func commaInString(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        return numberFormatter.string(from: price as NSNumber)!
    }
}
