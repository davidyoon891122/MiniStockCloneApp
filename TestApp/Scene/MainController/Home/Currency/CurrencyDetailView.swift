//
//  CurrencyDetailView.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import UIKit
import Charts

class CurrencyDetailView: UIView {
    
    weak var delegate: HomeViewProtocol?
    
    // MARK: - Chart Data Set
    private let years: [Double] = [2000, 2001, 2002, 2004, 2005, 2006]
    private let currency: [Double] = [1219.2, 1199.23, 1320.32, 1050.85, 1111.92, 1410.1]
    
    private lazy var topDragBar: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
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
        
        valueChangeLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        valueChangeLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        
        percentChangeLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        percentChangeLabel.leadingAnchor.constraint(equalTo: valueChangeLabel.trailingAnchor, constant: 10).isActive = true
        
        prevDayLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        prevDayLabel.leadingAnchor.constraint(equalTo: percentChangeLabel.trailingAnchor, constant: 10).isActive = true

        return stackView
    }()
    
    private lazy var valueChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "▼ 0.70원"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var percentChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "(-0.06%)"
        label.textColor = .blue
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var prevDayLabel: UILabel = {
        let label = UILabel()
        label.text = "전일 대비"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = MenuColor.shared.mintColor
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapConfirmButton), for: .touchUpInside)
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
}

private extension CurrencyDetailView {
    func addSubviews() {
        [topDragBar, currencyVStackView, lineChartView, confirmButton]
            .forEach {
                addSubview($0)
            }
    }
    
    func setLayoutConstraints() {
        topDragBar.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        topDragBar.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        topDragBar.widthAnchor.constraint(equalToConstant: 50).isActive = true
        topDragBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        
        currencyVStackView.topAnchor.constraint(equalTo: topDragBar.bottomAnchor, constant: 32).isActive = true
        currencyVStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        currencyVStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        
        lineChartView.topAnchor.constraint(equalTo: currencyVStackView.bottomAnchor, constant: 8).isActive = true
        lineChartView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        lineChartView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        confirmButton.topAnchor.constraint(equalTo: lineChartView.bottomAnchor, constant: 5).isActive = true
        confirmButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        confirmButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        confirmButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func tapConfirmButton() {
        delegate?.closeCurrenyDetailView()
    }
}
