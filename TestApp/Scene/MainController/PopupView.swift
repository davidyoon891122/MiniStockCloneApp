//
//  PopupView.swift
//  TestApp
//
//  Created by iMac on 2022/05/11.
//

import Foundation
import UIKit
import SnapKit
import RxSwift

final class GeneralPopupView {
    let currencyViewModel = CurrencyViewModel()
    let sortingSelectViewModel = SortingSelectViewModel()

    private let disposeBag = DisposeBag()

    private lazy var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(
            white: 0.2,
            alpha: 0.8
        )
        return view
    }()

    private var popupView = UIView()

    func openPopupView(popupView: UIView, viewHeight: CGFloat) {
        guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        self.popupView = popupView
        blackView.frame = window.frame
        blackView.alpha = 0
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBlackView)))
        [
            blackView,
            self.popupView
        ]
            .forEach {
                window.addSubview($0)
            }

        let popupViewHeightYOffset: CGFloat = window.frame.height - viewHeight

        self.popupView.frame = CGRect(
            x: 0,
            y: window.frame.height,
            width: window.frame.width,
            height: viewHeight
        )

        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self = self else { return }
                self.blackView.alpha = 1
                self.popupView.frame = CGRect(
                    x: 0,
                    y: popupViewHeightYOffset,
                    width: window.frame.width,
                    height: viewHeight
                )
            },
            completion: nil
        )
    }

   func tapBlackView() {
        print("tapBlackView")
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: { [weak self] in
                guard let self = self,
                      let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
                else { return }

                self.blackView.alpha = 0

                self.popupView.frame = CGRect(
                    x: 0,
                    y: window.frame.height,
                    width: self.popupView.frame.width,
                    height: self.popupView.frame.height
                )
            },
            completion: nil
        )
    }

    @objc func didTapBlackView() {
        tapBlackView()
    }

    func bindConfirmButton() {
        currencyViewModel.confirmButtonRelay
            .debug("bindConfirmButton DEBUG")
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapBlackView()
            })
            .disposed(by: disposeBag)
    }

    func bindSortingSelectionButtons() {
        sortingSelectViewModel.sortingButtonMenuPublishRelay
            .debug("bindSortingSelectButtons DEBUG")
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.tapBlackView()
            })
            .disposed(by: disposeBag)
    }
}
