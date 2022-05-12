//
//  SortingSelectViewModel.swift
//  TestApp
//
//  Created by iMac on 2022/05/11.
//

import Foundation
import RxSwift
import RxRelay

class SortingSelectViewModel {
    var sortingButtonMenuPublishRelay: PublishRelay<MyStockSortingMenu> = .init()
}
