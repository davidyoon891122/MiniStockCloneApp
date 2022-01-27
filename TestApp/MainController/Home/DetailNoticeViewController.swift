//
//  DetailNoticeViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/27.
//

import UIKit

class DetailNoticeViewController: UIViewController {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        
        [titleStackView, contentLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        [titleLabel, dateLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "신규 가능 거래 주식, ETF 추가 안내 (30개)"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .label
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2022.01.24."
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = """
        안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        \n안녕하세요. 미니스탁 입니다.
        """
        label.textColor = .label
        label.numberOfLines = 0
        
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setLayoutConstraint()
        configureNavigation()
        
    }
    
}

private extension DetailNoticeViewController {
    func configureNavigation() {
        navigationItem.title = "공지사항"
    }
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
    }
    
    func setLayoutConstraint() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
      
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
    }
}
