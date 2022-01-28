//
//  SeparatorView.swift
//  TestApp
//
//  Created by iMac on 2022/01/26.
//

import UIKit

class SeparatorView: UIView {
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
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
        separator.topAnchor.constraint(equalTo: topAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        separator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
}
