//
//  PasscodeCollectionViewCell.swift
//  TestApp
//
//  Created by Jiwon Yoon on 2023/01/21.
//

import UIKit
import SnapKit

final class PasscodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "PasscodeCollectionViewCell"

    private lazy var asteriskImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10.0

        return imageView
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        [
            asteriskImageView
        ]
            .forEach {
                view.addSubview($0)
            }

        asteriskImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.height.equalTo(20.0)
        }

        return view
    }()

    func setupCell() {
        setupViews()
    }
}

private extension PasscodeCollectionViewCell {
    func setupViews() {
        contentView.addSubview(containerView)

        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(5.0)
            $0.trailing.equalToSuperview().offset(-5.0)
            $0.bottom.equalToSuperview()
        }
    }
}
