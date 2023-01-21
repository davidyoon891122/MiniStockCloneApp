//
//  LoginViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    private let blackView = UIView()
    private let passwordView = PasswordViewController()
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        [
            titleLabel,
            welcomeLabel
        ]
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

        return button
    }()

    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindUI()
        
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

extension LoginViewController: UIViewControllerTransitioningDelegate {
    func presentationController(
        forPresented presented: UIViewController,
        presenting: UIViewController?,
        source: UIViewController
    ) -> UIPresentationController? {
        PasswordPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}

private extension LoginViewController {
    func setupViews() {
        [
            labelStackView,
            loginButton
        ]
            .forEach {
                view.addSubview($0)
            }

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

    @objc
    func handleAppDidBecomeActiveNotification(notification: Notification) {
        loginButtonTapped()
    }

    func loginButtonTapped() {
        let passwordViewController = PasswordViewController()
        passwordViewController.modalPresentationStyle = .custom
        passwordViewController.transitioningDelegate = self
        present(passwordViewController, animated: true)
    }

    func bindUI() {
        loginButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                self.loginButtonTapped()
            })
            .disposed(by: disposeBag)
    }
}
