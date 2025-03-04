//
//  LikeView.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/4/25.
//

import UIKit
import SnapKit
import Then

final class LikeView: BaseView {
    
    // MARK: - properties
    let searchBar = UISearchBar().then {
        $0.placeholder = "검색어를 입력하세요"
        $0.searchBarStyle = .minimal
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(ResultCollectionViewCell.self, forCellWithReuseIdentifier: ResultCollectionViewCell.identifier)
    }
    
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
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let lineSpacing: CGFloat = 0
        let horizontalInset: CGFloat = 12
        let interitemSpacing: CGFloat = 12
        let width = (UIScreen.main.bounds.size.width - (horizontalInset * 2) - interitemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width * 1.6)
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        
        return layout
    }
}
