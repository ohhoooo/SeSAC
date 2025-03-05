//
//  ShoppingView.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit
import SnapKit
import Then

final class ShoppingView: BaseView {
    
    // MARK: - properties
    let folderBarButtonItem = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "person.crop.circle")
    }
    
    let likeBarButtonItem = UIBarButtonItem().then {
        $0.style = .done
        $0.image = UIImage(systemName: "heart")
    }
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "브랜드, 상품, 프로필, 태그 등"
        $0.searchBarStyle = .minimal
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
}
