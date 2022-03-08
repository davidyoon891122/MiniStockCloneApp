//
//  InvestmentView.swift
//  TestApp
//
//  Created by iMac on 2022/01/20.
//

import UIKit
import SnapKit

protocol InvestmentViewProtocol: NSObject {
    func tapNoticeTableViewCell()
    func tapInvestmentBoardView()
}

class InvestmentView: UIView {
    private let separatorView = SeparatorView()
    
    weak var delegate: InvestmentViewProtocol?
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapVStackView))
        stackView.addGestureRecognizer(tapGestureRecognizer)
        
        [titleLabel, valueLabel, horizontalStackView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "윤지원님의\n투자현황입니다"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        
        let valueStringAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .heavy)]
        let wonStringAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .medium)]
        
        let value = NSMutableAttributedString(string: "3,480", attributes: valueStringAttribute)
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
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var redHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        
        [upDownLabel, changedValueLabel, percentageLabel]
            .forEach {
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
    
    private lazy var noticeTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        tableView.separatorStyle = .none
        return tableView
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
    
    func setupData(profit: ProfitModel) {
        titleLabel.text = "\(profit.userName)님의\n투자현황입니다."
        
        let valueStringAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .heavy)]
        let wonStringAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .medium)]
        
        let value = NSMutableAttributedString(
            string: profit.totalAsset.commaInString(),
            attributes: valueStringAttribute
        )
        let won = NSMutableAttributedString(string: "원", attributes: wonStringAttribute)
        
        value.append(won)
        
        valueLabel.attributedText = value
        changedValueLabel.text = profit.valueChange.commaInString()
        percentageLabel.text = "(+\(String(format: "%.2f", profit.percentChange))%)"
        baseDateLabel.text = profit.referenceDay + " 기준"
    }
}

extension InvestmentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NoticeTableViewCell.identifier,
            for: indexPath
        ) as? NoticeTableViewCell
        return cell ?? UITableViewCell()
    }
    
}

extension InvestmentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.tapNoticeTableViewCell()
    }
}

private extension InvestmentView {
    func addSubviews() {
        [verticalStackView, separatorView, noticeTableView]
            .forEach {
                addSubview($0)
            }
        
    }
    
    func setLayoutConstraint() {
        let inset: CGFloat = 16.0
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(verticalStackView.snp.bottom).offset(34)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            
        }
        
        noticeTableView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(50)
        }
    }
    
    @objc func tapVStackView() {
        delegate?.tapInvestmentBoardView()
    }
}
