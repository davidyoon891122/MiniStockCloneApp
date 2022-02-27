//
//  SeparatorView.swift
//  TestApp
//
//  Created by iMac on 2022/01/26.
//

import UIKit
import SnapKit

class SeparatorView: UIView {
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SeparatorView {
    func addSubviews() {
        addSubview(separator)
    }
    
    func setLayoutConstraint() {
        separator.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(0.8)
        }
    }
    
}
