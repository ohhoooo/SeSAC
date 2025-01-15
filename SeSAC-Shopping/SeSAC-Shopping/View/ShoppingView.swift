//
//  ShoppingView.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit
import SnapKit
import Then

final class ShoppingView: UIView {
    
    // MARK: - properties
    let searchBar = UISearchBar()
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - extensions
extension ShoppingView {
    private func configureUI() {
        configureView()
        configureSearchBar()
    }
    
    private func configureView() {
        backgroundColor = .white
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.searchBarStyle = .minimal
    }
    
    private func configureHierarchy() {
        addSubview(searchBar)
    }
    
    private func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}
