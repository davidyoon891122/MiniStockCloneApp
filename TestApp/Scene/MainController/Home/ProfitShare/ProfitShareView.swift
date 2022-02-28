//
//  ProfitShareView.swift
//  TestApp
//
//  Created by iMac on 2022/02/17.
//

import UIKit
import SnapKit

class ProfitShareView: UIView {
    weak var delegate: HomeViewProtocol?
    
    private lazy var labelVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        [firstLabel, secondLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
    
        return stackView
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.text = "수익률 공유, 재미지게~"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = MenuColor.shared.mintColor
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.text = "수익률 자랑하고 싶어요!"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "bear")
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraints()
        backgroundColor = .systemBackground
        setTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension ProfitShareView {
    func addSubviews() {
        [labelVStackView, imageView]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraints() {
        let inset: CGFloat = 16.0
        
        labelVStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(75)
            $0.trailing.equalToSuperview().inset(32)
        }
    }
    
    func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapProfitShareView))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapProfitShareView() {
        delegate?.moveToProfitShareDetailView()
    }
}
