//
//  SortingSelectView.swift
//  TestApp
//
//  Created by iMac on 2022/02/22.
//

import UIKit
import SnapKit

class SortingSelectView: UIView {
    
    weak var delegate: HomeViewProtocol?
    
    private lazy var topDragBar: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정렬순서"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var sortingSelectVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        [firstHStackView, secondHStackView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        stackView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        stackView.layer.borderWidth = 1
        stackView.layer.masksToBounds = true
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var firstHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        [priceButton, ganadaButton]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var priceButton: UIButton = {
        let button = UIButton()
        button.setTitle(MyStockSortingMenu.orderPrice.detailText, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(MenuColor.shared.mintColor, for: .highlighted)
        button.setTitleColor(MenuColor.shared.mintColor, for: .selected)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.addTarget(self, action: #selector(tapSortingButton(_:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    
    private lazy var ganadaButton: UIButton = {
        let button = UIButton()
        button.setTitle(MyStockSortingMenu.orderganada.detailText, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(MenuColor.shared.mintColor, for: .highlighted)
        button.setTitleColor(MenuColor.shared.mintColor, for: .selected)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.addTarget(self, action: #selector(tapSortingButton(_:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    
    private lazy var secondHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        [highButton, lowButton]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var highButton: UIButton = {
        let button = UIButton()
        button.setTitle(MyStockSortingMenu.orderHigh.detailText, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(MenuColor.shared.mintColor, for: .highlighted)
        button.setTitleColor(MenuColor.shared.mintColor, for: .selected)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.addTarget(self, action: #selector(tapSortingButton(_:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    
    private lazy var lowButton: UIButton = {
        let button = UIButton()
        button.setTitle(MyStockSortingMenu.orderlow.detailText, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(MenuColor.shared.mintColor, for: .highlighted)
        button.setTitleColor(MenuColor.shared.mintColor, for: .selected)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        button.addTarget(self, action: #selector(tapSortingButton(_:)), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCurrentSortingMenu(menu: MyStockSortingMenu) {
        [priceButton, ganadaButton, highButton, lowButton]
            .forEach {
                $0.isSelected = false
            }
        
        switch menu {
        case .orderPrice:
            priceButton.isSelected = true
        case .orderganada:
            ganadaButton.isSelected = true
        case .orderHigh:
            highButton.isSelected = true
        case .orderlow:
            lowButton.isSelected = true
        }
    }
}

private extension SortingSelectView {
    
    func setupViews() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 10
        addSubviews()
        setLayoutConstraint()
    }
    
    func addSubviews() {
        [topDragBar, titleLabel, sortingSelectVStackView]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        let inset: CGFloat = 16.0
        
        topDragBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topDragBar.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        sortingSelectVStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(100)
        }
    }
    
    @objc func tapSortingButton(_ sender: UIButton) {
        
        switch sender.tag {
        case 0:
            let sortingMenu = MyStockSortingMenu.orderPrice
            delegate?.sortingButtonSelected(menu: sortingMenu)
        case 1:
            let sortingMenu = MyStockSortingMenu.orderganada
            delegate?.sortingButtonSelected(menu: sortingMenu)
        case 2:
            let sortingMenu = MyStockSortingMenu.orderHigh
            delegate?.sortingButtonSelected(menu: sortingMenu)
        case 3:
            let sortingMenu = MyStockSortingMenu.orderlow
            delegate?.sortingButtonSelected(menu: sortingMenu)
        default:
            print("error")
        }
        
    }
}
