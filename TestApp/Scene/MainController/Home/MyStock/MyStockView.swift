//
//  MyStockView.swift
//  TestApp
//
//  Created by iMac on 2022/01/21.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MyStockView: UIView {
    private let disposeBag = DisposeBag()
    private var cellCount: Int {
        didSet {
            self.stockTableView.snp.updateConstraints {
                $0.height.equalTo(CGFloat(self.myStocks.count) * self.cellHeight)
            }
        }
    }
    private let dividendView = DividendView()
    
    private var sortingMenu: MyStockSortingMenu = .orderganada
    
    private var myStocks: [MyStockModel] = []
    
    private let cellHeight: CGFloat = 60.0

    private var viewModel: HomeViewModel?

    weak var delegate: HomeViewProtocol?

    private lazy var titleHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally

        stackView.axis = .horizontal
        sortingButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        [titleLabel, sortingButtonHStack]
            .forEach {
                stackView.addArrangedSubview($0)
            }

        return stackView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "보유 주식"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    private lazy var sortingButtonHStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.addArrangedSubview(sortingButton)
        return stackView
    }()

    private lazy var sortingButton: UIButton = {
        let button = UIButton()
        button.setTitle(sortingMenu.text, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(tapSortingButton), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        return button
    }()

    private lazy var dividendButton: UIButton = {
        let button = UIButton()
        button.setTitle("1개의 주식에서 배당이 나올 예정이에요 ⌵", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .light)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = MenuColor.shared.lightGrayColor
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()

    private lazy var myStockVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        dividendButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        [titleHStackView, dividendButton]
            .forEach {
                stackView.addArrangedSubview($0)
            }

        return stackView
    }()

    private lazy var stockTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            MyStockViewTableCell.self,
            forCellReuseIdentifier: MyStockViewTableCell.identifier
        )
        tableView.rowHeight = cellHeight
        tableView.estimatedRowHeight = 88.0
        return tableView
    }()
    
    override init(frame: CGRect) {
        cellCount = 1
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraint()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewModel(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        bindViewModel()
    }
    
    func setupDividendData(dividends: [DividendModel]) {
        self.dividendView.setupData(dividends: dividends)
    }
    
    func setDividendDelegate(viewController: HomeViewProtocol) {
        dividendView.delegate = viewController
    }
    
    func setSortingMenu(menu: MyStockSortingMenu) {
        sortingMenu = menu
        sortingButton.setTitle(sortingMenu.text, for: .normal)
        
    }
    
    func getCurrentSortingMenu() -> MyStockSortingMenu {
        return sortingMenu
    }
}

private extension MyStockView {
    func addSubviews() {
        [myStockVStackView, stockTableView, dividendView]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraint() {
        let inset: CGFloat = 16.0
        
        myStockVStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        stockTableView.snp.makeConstraints {
            $0.top.equalTo(myStockVStackView.snp.bottom).offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(CGFloat(cellCount) * cellHeight)
        }
        
        dividendView.snp.makeConstraints {
            $0.top.equalTo(stockTableView.snp.bottom).offset(inset)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
    @objc func tapSortingButton() {
        print("did tap sortingButton.")
        delegate?.openSortingButtonView()
    }

    func bindViewModel() {
        guard let viewModel = self.viewModel else { return }
        viewModel.myStocksSubject
            .subscribe(onNext: { [weak self] myStocks in
                guard let self = self else { return }
                self.myStocks = myStocks
                self.cellCount = self.myStocks.count
                self.stockTableView.reloadData()

            }, onError: { error in
                print(error)
            }
            )
            .disposed(by: disposeBag)

        bindUI()
    }

    func bindUI() {
        stockTableView.delegate = nil
        stockTableView.dataSource = nil
        guard let viewModel = self.viewModel else { return }
        viewModel.myStocksRelay
            .observe(on: MainScheduler.instance)
            .bind(to: stockTableView.rx.items(
                cellIdentifier: MyStockViewTableCell.identifier,
                cellType: MyStockViewTableCell.self)
            ) { row, element, cell in
                print("row: \(row), element: \(element), cell: \(cell)")
                let stock = self.myStocks[row]
                cell.setup(myStock: stock)
            }
            .disposed(by: disposeBag)

    }
}
