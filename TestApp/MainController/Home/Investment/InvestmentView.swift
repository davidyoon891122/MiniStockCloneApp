//
//  InvestmentView.swift
//  TestApp
//
//  Created by iMac on 2022/01/20.
//

import UIKit

protocol InvestmentViewProtocol: NSObject {
    func tapNoticeTableViewCell()
    func tapInvestmentBoardView()
}

class InvestmentView: UIView, UIGestureRecognizerDelegate {
    private let noticeCellId = "noticeCellId"

    private let separatorView = SeparatorView()
    
    weak var delegate: InvestmentViewProtocol?
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapVStackView))
        tapGestureRecognizer.delegate = self
        stackView.addGestureRecognizer(tapGestureRecognizer)
        
        [titleLabel, valueLabel, horizontalStackView]
            .forEach {
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
        tableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: noticeCellId)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
}

extension InvestmentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: noticeCellId, for: indexPath) as? NoticeTableViewCell
        return cell ?? UITableViewCell()
    }
    
}

extension InvestmentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("NoticeTableViewCell tapped..")
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
        verticalStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        separatorView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 35).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        noticeTableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor
        ).isActive = true
        noticeTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        noticeTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        noticeTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        noticeTableView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func tapVStackView() {
        delegate?.tapInvestmentBoardView()
    }
}
