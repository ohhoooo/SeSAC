//
//  FolderView.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/5/25.
//

import UIKit
import SnapKit
import Then

final class FolderView: BaseView {
    
    // MARK: - properties
    let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(FolderCell.self, forCellReuseIdentifier: FolderCell.identifier)
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
