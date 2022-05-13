//
//  CurrencyView.swift
//  TestApp
//
//  Created by iMac on 2022/02/17.
//

import UIKit
import SnapKit

class CurrencyView: UIView {
    weak var delegate: HomeViewProtocol?
    
    private lazy var currencyHStackView: UIStackView = {
        let stackView = UIStackView()
        [
            leftVStackView,
            rightVStackView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var leftVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        [
            currencyTitleLabel,
            currencySubtitleLabel
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        return stackView
    }()
    
    private lazy var rightVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        [
            currencyContentLabel,
            changeHStackView
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var changeHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        [
            valueChangeLabel,
            percentChangeLabel
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        return stackView
    }()
    
    private lazy var currencyTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "원∙달러 환율"
        label.font = .systemFont(
            ofSize: 18,
            weight: .medium
        )
        label.textColor = .label
        return label
    }()
    
    private lazy var currencyContentLabel: UILabel = {
        let label = UILabel()
        label.text = "1,198.50원"
        label.textAlignment = .right
        label.font = .systemFont(
            ofSize: 18,
            weight: .medium
        )
        label.textColor = .label
        return label
    }()
    
    private lazy var currencySubtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2월 16일 최고고시환율"
        label.font = .systemFont(
            ofSize: 12,
            weight: .medium
        )
        label.textColor = .gray
        return label
    }()
    
    private lazy var valueChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "0.20원"
        label.font = .systemFont(
            ofSize: 14,
            weight: .medium
        )
        label.textColor = .red
        return label
    }()
    
    private lazy var percentChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "+0.02%"
        label.font = .systemFont(
            ofSize: 14,
            weight: .medium
        )
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubviews()
        setLayoutConstraints()
        setTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CurrencyView {
    func addSubviews() {
        addSubview(currencyHStackView)
    }
    
    func setLayoutConstraints() {
        let inset: CGFloat = 16.0
        
        currencyHStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.bottom.equalToSuperview().inset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
    }
    
    func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapCurrencyView)
        )
        addGestureRecognizer(tapGesture)
        
    }
    
    @objc func didTapCurrencyView() {
        delegate?.openCurrenyDetailView()
    }
}
