//
//  InvestmentView.swift
//  TestApp
//
//  Created by iMac on 2022/01/20.
//

import UIKit

class InvestmentView: UIView {
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        [titleLabel, valueLabel, horizontalStackView]
            .forEach{
                stackView.addArrangedSubview($0)
            }
        
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "윤지원님의\n투자현황입니다"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        let valueStringAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .heavy)]
        let wonStringAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .medium)]
        
        let value = NSMutableAttributedString(string: "2,447", attributes: valueStringAttribute)
        let won = NSMutableAttributedString(string: "원", attributes: wonStringAttribute)
        
        value.append(won)
        label.attributedText = value
        label.textColor = .label
        
        return label
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing

        [redHStackView, baseDateLabel]
            .forEach{
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    
    private lazy var redHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        [upDownLabel, changedValueLabel, percentageLabel]
            .forEach{
                stackView.addArrangedSubview($0)
            }
        return stackView
    }()
    
    
    private lazy var upDownLabel: UILabel = {
        let label = UILabel()
        label.text = "▲"
        label.textColor = .red
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var changedValueLabel: UILabel = {
        let label = UILabel()
        label.text = "453원"
        label.textColor = .red
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.text = "(+22.52%)"
        label.textColor = .red
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var baseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "1월 20일 기준"
        label.textAlignment = .right
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
        backgroundColor = .systemBackground
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


private extension InvestmentView {
    func addSubviews() {
        addSubview(verticalStackView)
        
    }
    
    func setLayoutConstraint() {
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
}
