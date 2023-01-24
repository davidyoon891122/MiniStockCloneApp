//
//  PasswordView.swift
//  TestApp
//
//  Created by iMac on 2022/01/17.
//

import UIKit
import SnapKit
import RxSwift

final class PasswordViewController: UIViewController {
    private lazy var topDragBar: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "간편비밀번호"
        label.font = .systemFont(
            ofSize: 30,
            weight: .medium
        )
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "6자리를 입력해 주세요"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(
            ofSize: 15,
            weight: .light
        )
        return label
    }()

    private lazy var labelView: UIView = {
        let view = UIView()
        [
            titleLabel,
            descriptionLabel
        ]
            .forEach {
                view.addSubview($0)
            }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        return view
    }()

    private lazy var passcodeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            PasscodeCollectionViewCell.self,
            forCellWithReuseIdentifier: PasscodeCollectionViewCell.identifier
        )

        return collectionView
    }()
    
    lazy var numberCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            PasswordNumberCollectionViewCell.self,
            forCellWithReuseIdentifier: PasswordNumberCollectionViewCell.identifier
        )
        return collectionView
    }()

    private var keypadNumbers = [
        1, 2, 3, 4, 5, 6, 7, 8, 9, 0
    ]

    private var userPassword = ""

    private var selects: [Bool] = [false, false, false, false, false, false]

    private var hasSetPointOrigin = false
    private var pointOrigin: CGPoint?

    private let viewModel: PasswordViewModelType = PasswordViewModel()
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        setupViews()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = view.frame.origin
        }
    }
    
    deinit {
        print("PasswordViewController Deinit")
    }
    
}

extension PasswordViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        if collectionView == numberCollectionView {
            return 12
        } else if collectionView == passcodeCollectionView {
            return selects.count
        } else {
            return 0
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        if collectionView == numberCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PasswordNumberCollectionViewCell.identifier,
                for: indexPath
            ) as? PasswordNumberCollectionViewCell else { return UICollectionViewCell() }

            let randomNumber = keypadNumbers.randomElement()

            if indexPath.row != 9 && indexPath.row != 11 {
                keypadNumbers.removeAll(where: {$0 == randomNumber})
                cell.setupCell(title: "\(randomNumber ?? 0)")
            } else if indexPath.row == 9 {
                cell.setupCell(title: "")
            } else if indexPath.row == 11 {
                cell.setupCell(title: "◀︎")
            }

            return cell
        } else if collectionView == passcodeCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PasscodeCollectionViewCell.identifier,
                for: indexPath
            ) as? PasscodeCollectionViewCell else { return UICollectionViewCell() }
            let select = selects[indexPath.row]
            cell.setupCell(isSelected: select)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PasswordNumberCollectionViewCell,
              let text = cell.getTitle()
        else { return }

        cell.activateAnimation()
        
        if text == "◀︎" && userPassword.count > 0 {
            selects[userPassword.count - 1] = !selects[userPassword.count - 1]
            let index = IndexPath(item: userPassword.count - 1, section: 0)
            passcodeCollectionView.reloadItems(at: [index])
            userPassword.remove(at: userPassword.index(before: userPassword.endIndex))
        } else if text == "" || userPassword.count < 0 {
            //
        } else if Int(text) != nil {
            userPassword += text
            selects[userPassword.count - 1] = !selects[userPassword.count - 1]
            let index = IndexPath(item: userPassword.count - 1, section: 0)
            passcodeCollectionView.reloadItems(at: [index])
        }

        if userPassword.count == 6 {
            self.viewModel.inputs.checkPassword(passcodes: userPassword)
        }
    }
    
}

extension PasswordViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        if collectionView == numberCollectionView {
            return CGSize(width: collectionView.frame.width / 3, height: 70)
        } else if collectionView == passcodeCollectionView {
            return CGSize(width: 30.0, height: 20.0)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
}

private extension PasswordViewController {
    func setupViews() {
        [
            topDragBar,
            labelView,
            passcodeCollectionView,
            numberCollectionView
        ]
            .forEach {
                view.addSubview($0)
            }

        topDragBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(70)
            $0.height.equalTo(5)
        }

        labelView.snp.makeConstraints {
            $0.top.equalTo(topDragBar.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview()
        }

        passcodeCollectionView.snp.makeConstraints {
            $0.top.equalTo(labelView.snp.bottom).offset(32.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(20 * 6 + 60)
            $0.height.equalTo(20.0)
        }

        numberCollectionView.snp.makeConstraints {
            $0.top.equalTo(passcodeCollectionView.snp.bottom).offset(32.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(panGestureRecognizerAction)
        )

        view.addGestureRecognizer(panGesture)
    }

    func bindViewModel() {
        viewModel.outputs.checkResultPublishSubject
            .subscribe(onNext: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case true:
                    let homeTabBarController = HomeTabBarController()
                    guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
                    window.rootViewController = homeTabBarController
                case false:
                    print("Reset pasword")
                    self.userPassword = ""
                    self.selects = [false, false, false, false, false, false]
                    self.passcodeCollectionView.reloadSections(IndexSet(integer: 0))
                }
            })
            .disposed(by: disposeBag)
    }

    @objc
    func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)

        guard translation.y >= 0 else { return }

        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)

        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 600)
                }
            }
        }
    }
}
