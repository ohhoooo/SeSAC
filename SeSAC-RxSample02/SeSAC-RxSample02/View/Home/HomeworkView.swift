//
//  HomeworkView.swift
//  SeSAC-RxSample02
//
//  Created by 김정호 on 2/27/25.
//

import UIKit
import SnapKit
import Then
import Kingfisher

final class HomeworkView: UIView {
    
    // MARK: - properties
    let searchBar = UISearchBar()
    
    let tableView = UITableView().then {
        $0.rowHeight = 100
        $0.backgroundColor = .systemGreen
        $0.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.backgroundColor = .lightGray
        $0.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
    }
    
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
    
    // MARK: - methods
    private func configureUI() {
        backgroundColor = .white
    }
    
    private func configureHierarchy() {
        addSubview(tableView)
        addSubview(collectionView)
        addSubview(searchBar)
    }
    
    private func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(50)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
}
