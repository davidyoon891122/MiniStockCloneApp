//
//  LoginViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    let passwordView = PasswordView()
    var isOpend = MenuStatus.close
    
    enum MenuStatus {
        case open
        case close
    }
    
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
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setLayoutConstraint()
        
        view.addSubview(passwordView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginButtonTapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}


extension LoginViewController {
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
    
    
    @objc func loginButtonTapped() {
        
//        let window = UIApplication.shared.connectedScenes
//            .filter{
//                $0.activationState == .foregroundActive
//            }.map {
//                $0 as? UIWindowScene
//            }.compactMap{
//                $0
//            }.first?.windows
//            .filter{
//                $0.isKeyWindow
//            }.first
        switch isOpend {
        case .open:
            print("open")
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                self.passwordView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 0)

            }, completion: {[weak self] _ in
                           guard let self = self else { return }
                           self.isOpend = .close
            }
            )
//
        case .close:
            print("closed")
//            window?.alpha = 0.8
//            window?.addSubview(passwordView)
            let y = view.frame.height - 500
            print(y)
            passwordView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 0)
            passwordView.layer.cornerRadius = 10
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
                guard let self = self else { return }
                
                self.passwordView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: 500)
            }, completion: { [weak self] _ in
                guard let self = self else { return }
                self.isOpend = .open
            
            })
        }
        
        
    }
}
