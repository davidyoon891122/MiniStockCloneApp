//
//  HomeViewProtocol.swift
//  TestApp
//
//  Created by iMac on 2022/02/21.
//

import Foundation

protocol HomeViewProtocol: NSObject {
    func upScrollAction()
    func moveToDetailStockView()
    func moveToProfitShareDetailView()
    func openCurrenyDetailView()
    func closeCurrenyDetailView()
}
