//
//  LegalBoardView.swift
//  TestApp
//
//  Created by iMac on 2022/02/17.
//

import UIKit
import SnapKit

class LegalBoardView: UIView {
    weak var delegate: HomeViewProtocol?
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(
            ofSize: 14,
            weight: .medium
        )
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var upScrollButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "arrow.up"),
            for: .normal
        )
        button.backgroundColor = .white
        button.tintColor = .gray
        button.layer.cornerRadius = 20
        button.addTarget(
            self,
            action: #selector(tapUpScrollButton),
            for: .touchUpInside
        )
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraints()
        setLegalText()
        backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension LegalBoardView {
    func addSubviews() {
        [mainLabel, upScrollButton]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraints() {
        let inset: CGFloat = 16.0
        
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.bottom.equalToSuperview().inset(inset)
        }
        
        upScrollButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.width.equalTo(40)
            $0.height.equalTo(40)
        }
    }
    
    func setLegalText() {
        mainLabel.text = """
        주가 및 뉴스(연합인포맥스), 재무정보(모닝스타)는 각
        컨텐츠 제공업체로부터 받는 정보로 오류 및 지연이 발
        생될 수 있으며, 미니스탁(한국투자증권)은 투자결과에
        대한 법적인 책임을 지지 않습니다.
        """
    }
    
    @objc func tapUpScrollButton() {
        delegate?.upScrollAction()
    }
}
