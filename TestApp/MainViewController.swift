//
//  MainViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [titleLabel, welcomeLabel]
            .forEach{
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.text = "ministock"
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .light)
        label.text = "환영합니다"
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton:UIButton = {
        let button = UIButton()
        button.setTitle("간편비밀번호 로그인", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.separator.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayoutConstraint()
    }
}


extension MainViewController {
    func addSubviews() {
        [labelStackView, loginButton]
            .forEach{
                view.addSubview($0)
            }
        
        
    }
    
    func setLayoutConstraint() {
        labelStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        
        
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive =  true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
