//
//  PasswordNumberCollectionViewCell.swift
//  TestApp
//
//  Created by iMac on 2022/01/18.
//

import UIKit
import SnapKit

final class PasswordNumberCollectionViewCell: UICollectionViewCell {
    static let identifier = "PasswordNumberCollectionViewCell"

    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textColor = .label
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.separator.cgColor
        return label
    }()

    func setupCell(title: String) {
        numberLabel.text = title
        setupViews()
    }

    func getTitle() -> String? {
        return numberLabel.text
    }
}

private extension PasswordNumberCollectionViewCell {
    func setupViews() {
        contentView.addSubview(numberLabel)

        numberLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
