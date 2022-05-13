//
//  MenuCollectionViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/28.
//

import UIKit
import SnapKit

class MenuCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "MenuCollectionViewCell"
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var menuBar: UIView = {
        let view = UIView()
        view.backgroundColor = MenuColor.shared.mintColor
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? MenuColor.shared.mintColor : .label
            isSelected ? selectedAction() : deselectAction()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        self.titleLabel.text = title
    }
    
    func selectedAction() {
        addSubview(menuBar)

        menuBar.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(2)
        }
    }
    
    func deselectAction() {
        menuBar.removeFromSuperview()
        titleLabel.textColor = .label
    }
    
}

private extension MenuCollectionViewCell {
    func addSubviews() {
        [
            titleLabel
        ]
            .forEach {
                contentView.addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
