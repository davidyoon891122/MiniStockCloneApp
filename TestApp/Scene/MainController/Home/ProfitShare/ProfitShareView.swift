//
//  ProfitShareView.swift
//  TestApp
//
//  Created by iMac on 2022/02/17.
//

import UIKit

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
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        labelVStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        labelVStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        labelVStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32).isActive = true
    }
    
    func setTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapProfitShareView))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func tapProfitShareView() {
        delegate?.moveToProfitShareDetailView()
    }
}
