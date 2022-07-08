//
//  DividendView.swift
//  TestApp
//
//  Created by iMac on 2022/01/26.
//

import UIKit
import SnapKit
import RxSwift

class DividendView: UIView {
    private let disposeBag = DisposeBag()
    private var dividends: [DividendModel] = []
    
    weak var delegate: HomeViewProtocol?

    private var viewModel: HomeViewModel?

    private lazy var currentCollectionViewX = stockCollectionView.frame.origin.x
    
    private lazy var labelVStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        [
            labelHStack,
            titleLabel
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }

        return stackView
    }()
    
    private lazy var labelHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        [
            descriptionLabel,
            dividendBaseLabel
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "은행 이자 부럽지 않은 배당"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var dividendBaseLabel: UILabel = {
        let label = UILabel()
        label.text = "미국 배당락일 기준 ⍰"
        label.textAlignment = .right
        
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .white
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 사면 배당받는 주식!"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var stockCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = MenuColor.shared.mintColor
        collectionView.register(
            DividendCollectionViewCell.self,
            forCellWithReuseIdentifier: DividendCollectionViewCell.identifier
        )
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = MenuColor.shared.mintColor
        addSubviews()
        setLayoutConstraint()
        activateCollectionViewAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewModel(viewModel: HomeViewModel) {
        self.viewModel = viewModel

        bindViewModel()
    }
}

extension DividendView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return dividends.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DividendCollectionViewCell.identifier,
            for: indexPath
        ) as? DividendCollectionViewCell
        let dividend = dividends[indexPath.row]
        cell?.setupData(dividend: dividend)
        return cell ?? UICollectionViewCell()
    }
}

extension DividendView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(
            width: UIScreen.main.bounds.width / 3 - 20,
            height: 150.0
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.moveToDetailStockView()
    }
}

private extension DividendView {
    func addSubviews() {
        [
            labelVStack,
            stockCollectionView
        ]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        let inset: CGFloat = 16.0

        labelVStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        stockCollectionView.snp.makeConstraints {
            $0.top.equalTo(labelVStack.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(inset)
            $0.height.equalTo(150)
        }
    }

    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        viewModel.dividendsSubject
            .subscribe(onNext: { [weak self] dividends in
                guard let self = self else { return }
                self.dividends = dividends
                self.stockCollectionView.reloadData()
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

    func activateCollectionViewAnimation() {
        _ = Timer.scheduledTimer(
            timeInterval: 0.1
            ,
            target: self,
            selector: #selector(moveCollectionViewCell),
            userInfo: nil,
            repeats: true
        )
    }

    @objc func moveCollectionViewCell() {
        print(currentCollectionViewX)
        stockCollectionView.setContentOffset(
            CGPoint(
                x: currentCollectionViewX,
                y: 0
            ),
            animated: true
        )
        let collectionViewContentMaxWidth = stockCollectionView.contentSize.width
        let collectionViewMaxWidth = stockCollectionView.frame.width

        if currentCollectionViewX < collectionViewContentMaxWidth - collectionViewMaxWidth {
            currentCollectionViewX += 1.0
        } else {
            print("End Moving")
            currentCollectionViewX = 0.0
        }
    }
}
