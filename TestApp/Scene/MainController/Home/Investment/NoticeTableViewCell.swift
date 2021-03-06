//
//  NoticeTableViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/26.
//

import UIKit
import SnapKit

class NoticeTableViewCell: UITableViewCell {
    static let identifier: String = "NoticeTableViewCell"
    
    private lazy var noticeHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        noticeTitleLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        [noticeTitleLabel, noticeContentsLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var noticeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "공지"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = MenuColor.shared.mintColor
        return label
    }()
    
    private lazy var noticeContentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.text = "신규 가능 거래 주식, ETF 추가 안내(30개)"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setLayoutConstraint()
        self.accessoryType = .disclosureIndicator
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension NoticeTableViewCell {
    func addSubviews() {
        contentView.addSubview(noticeHStack)
    }
    
    func setLayoutConstraint() {
        noticeHStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
