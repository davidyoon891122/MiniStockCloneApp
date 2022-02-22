//
//  StockListMenuCollectionView.swift
//  TestApp
//
//  Created by iMac on 2022/02/04.
//

import UIKit

protocol StockListViewProtocol: AnyObject {
    func selectMenu(indexPath: IndexPath)
}

class StockListMenuCollectionView: UICollectionView {
    private var menus: [String] = []
    weak var menuDelegate: StockListViewProtocol?
    
    init(menus: [String]) {
        self.menus = menus
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 30
        super.init(frame: .zero, collectionViewLayout: layout)
        configureCollectionView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveMenuWithStockListMainCollectionView(indexPath: IndexPath) {
        selectItem(at: indexPath, animated: true, scrollPosition: .right)
    }
    
}

extension StockListMenuCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menus.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell
        cell?.setup(title: menus[indexPath.row])
        if indexPath.row == 0 {
            cell?.selectedAction()
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
        
        return cell ?? UICollectionViewCell()
    }
    
}

extension StockListMenuCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = menus[indexPath.row]
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return CGSize(width: label.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuDelegate?.selectMenu(indexPath: indexPath)
    }
}

private extension StockListMenuCollectionView {
    func configureCollectionView() {
        self.delegate = self
        self.dataSource = self
        self.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
        contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        showsHorizontalScrollIndicator = false
    }
}
