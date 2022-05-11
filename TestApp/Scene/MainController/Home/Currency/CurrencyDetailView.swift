//
//  CurrencyDetailView.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import UIKit
import Charts
import SnapKit
import RxSwift
import RxCocoa

class CurrencyDetailView: UIView {
    
    weak var delegate: HomeViewProtocol?
    private var viewModel: CurrencyViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: - Chart Data Set
    private let years: [Double] = [2000, 2001, 2002, 2004, 2005, 2006]
    private let currency: [Double] = [1219.2, 1199.23, 1320.32, 1050.85, 1111.92, 1410.1]
    
    private lazy var topDragBar: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var currencyVStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        [titleHStackView, currentCurrencyLabel, valueHStackView]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "USFlag")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var titleHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        [imageView, titleLabel, descriptionLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "원∙달러 환율"
        label.textColor = .label
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "2월 21일 최초고시환율"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    private lazy var currentCurrencyLabel: UILabel = {
        let label = UILabel()
        label.text = "1,196.40원"
        label.textColor = .label
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private lazy var valueHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        [valueChangeLabel, percentChangeLabel, prevDayLabel]
            .forEach {
                stackView.addSubview($0)
            }
        
        valueChangeLabel.snp.makeConstraints {
            $0.centerY.equalTo(stackView)
            $0.leading.equalTo(stackView)
        }
        
        percentChangeLabel.snp.makeConstraints {
            $0.centerY.equalTo(stackView)
            $0.leading.equalTo(valueChangeLabel.snp.trailing).offset(10)
        }
        
        prevDayLabel.snp.makeConstraints {
            $0.centerY.equalTo(stackView)
            $0.leading.equalTo(percentChangeLabel.snp.trailing).offset(10)
        }

        return stackView
    }()
    
    private lazy var valueChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "▼ 0.70원"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private lazy var percentChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "(-0.06%)"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    private lazy var prevDayLabel: UILabel = {
        let label = UILabel()
        label.text = "전일 대비"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .medium)
        
        return label
    }()
    
    private lazy var lineChartView: LineChartView  = {
        let chart = LineChartView()
        var lineChartEntry = [ChartDataEntry]()
        for index in 0..<years.count {
            let value = ChartDataEntry(x: years[index], y: currency[index])
            lineChartEntry.append(value)
        }
        let line = LineChartDataSet(entries: lineChartEntry, label: "Currency")
        line.colors = [MenuColor.shared.mintColor]
        let data = LineChartData()
        data.addDataSet(line)
        chart.data = data
        // left
        chart.leftAxis.drawLabelsEnabled = false
        chart.leftAxis.drawGridLinesEnabled = false
        chart.leftAxis.drawAxisLineEnabled = false
        // right
        chart.rightAxis.drawAxisLineEnabled = false
        chart.rightAxis.drawLabelsEnabled = false
        chart.rightAxis.drawGridLinesEnabled = false
        // x
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.drawGridLinesEnabled = false
        chart.xAxis.drawAxisLineEnabled = false
        chart.xAxis.drawLabelsEnabled = false
        
        chart.doubleTapToZoomEnabled = false
        chart.legend.enabled = false
        
        return chart
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = MenuColor.shared.mintColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraints()
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setViewModel(viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        bindUI()
    }
}

private extension CurrencyDetailView {
    func addSubviews() {
        [
            topDragBar,
            currencyVStackView,
            lineChartView,
            confirmButton
        ]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraints() {
        let inset: CGFloat = 16.0
        
        topDragBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(50)
            $0.height.equalTo(5)
        }
        
        currencyVStackView.snp.makeConstraints {
            $0.top.equalTo(topDragBar.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        lineChartView.snp.makeConstraints {
            $0.top.equalTo(currencyVStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(lineChartView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
            $0.height.equalTo(50)
        }
        
    }

    func bindUI() {
        guard let viewModel = self.viewModel else { return }

        confirmButton.rx.tap
            .bind(to: viewModel.confirmButtonRelay)
            .disposed(by: disposeBag)

    }
}
