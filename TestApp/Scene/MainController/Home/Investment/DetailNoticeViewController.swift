//
//  DetailNoticeViewController.swift
//  TestApp
//
//  Created by iMac on 2022/01/27.
//

import UIKit
import SnapKit

class DetailNoticeViewController: UIViewController {
    private let scrollView: UIScrollView = UIScrollView()
    
    private let contentView: UIView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        
        [titleStackView, contentLabel]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
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
        \n
        \n많은 분들이 요청해주셨던 주식과 기업규모, 거래
        \n량 등 내부 기준으로 검토한 내용을 바탕으로
        \n아래와 같이 미니스탁에서 거래 가능한 주식과
        \nETF가 추가되었습니다.
        \n
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
        let inset: CGFloat = 16.0
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(inset)
            $0.leading.equalToSuperview().offset(inset)
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
