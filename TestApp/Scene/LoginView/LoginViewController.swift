//
//  LoginViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    let blackView = UIView()
    var passwordView = PasswordView()
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        [titleLabel, welcomeLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        let miniStringAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 40,
                weight: .heavy
            ),
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        let stockStringAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(
                ofSize: 40,
                weight: .light
            ),
            NSAttributedString.Key.foregroundColor: UIColor.label
        ]
        
        let miniString = NSMutableAttributedString(
            string: "mini",
            attributes: miniStringAttribute
        )
        let stockString = NSMutableAttributedString(
            string: "stock",
            attributes: stockStringAttribute
        )
        
        miniString.append(stockString)
        
        label.attributedText = miniString
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(
            ofSize: 25,
            weight: .light
        )
        label.text = "환영합니다"
        label.textAlignment = .center
        label.textColor = MenuColor.shared.mintColor
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            "간편비밀번호 로그인",
            for: .normal
        )
        button.setTitleColor(
            .label,
            for: .normal
        )
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.separator.cgColor
        button.layer.borderWidth = 1
        button.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayoutConstraint()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleAppDidBecomeActiveNotification(notification:)),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginButtonTapped()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension LoginViewController {
    func addSubviews() {
        [labelStackView, loginButton]
            .forEach {
                view.addSubview($0)
            }
        
    }
    
    func setLayoutConstraint() {
        labelStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.trailing.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(80.0)
            $0.height.equalTo(50)
        }
        
    }
    
    @objc func loginButtonTapped() {
        guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
        passwordView.keypadNumbers = [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 0
        ]
        passwordView.numberCollectionView.reloadData()
        blackView.backgroundColor = UIColor(
            white: 0.2,
            alpha: 0.8
        )
        blackView.frame = window.frame
        blackView.alpha = 0
        blackView.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(tapBlackView)
            )
        )
        
        [
            blackView,
            passwordView
        ]
            .forEach {
                window.addSubview($0)
            }
        
        let height: CGFloat  = 600
        let passwordViewY = window.frame.height - height
        
        self.passwordView.frame = CGRect(
            x: 0,
            y: window.frame.height,
            width: window.frame.width,
            height: height
        )
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
            self.blackView.alpha = 1
            self.passwordView.frame = CGRect(
                x: 0,
                y: passwordViewY,
                width: window.frame.width,
                height: height
            )
        }, completion: nil)
    }
    
    @objc func tapBlackView() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
            self.blackView.alpha = 0
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow})
            else {
                return
            }
            
            self.passwordView.frame = CGRect(
                x: 0,
                y: window.frame.height,
                width: self.passwordView.frame.width,
                height: self.passwordView.frame.height
            )
            
        }, completion: nil)
    }
    
    @objc func handleAppDidBecomeActiveNotification(notification: Notification) {
        loginButtonTapped()
    }
}
