//
//  WishListView.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/26/25.
//

import UIKit
import SnapKit
import Then

final class WishListView: BaseView {
    
    // MARK: - properties
    let searchBar = UISearchBar()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .green
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
}
