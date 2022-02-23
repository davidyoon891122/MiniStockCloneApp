//
//  SortingSelectView.swift
//  TestApp
//
//  Created by iMac on 2022/02/22.
//

import UIKit

class SortingSelectView: UIView {
    
    weak var delegate: HomeViewProtocol?
    
    private lazy var topDragBar: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "정렬순서"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        topDragBar.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        topDragBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topDragBar.widthAnchor.constraint(equalToConstant: 50).isActive = true
        topDragBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topDragBar.bottomAnchor, constant: 32).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        sortingSelectVStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        sortingSelectVStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        sortingSelectVStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        sortingSelectVStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
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
