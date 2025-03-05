//
//  FolderCell.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/5/25.
//

import UIKit
import SnapKit
import Then

final class FolderCell: BaseTableViewCell {
    
    // MARK: - properties
    static let identifier = "FolderCell"
    
    private let nameLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
    }
    
    private let countLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .clear
    }
    
    override func configureHierarchy() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
    }
    
    override func configureConstraints() {
        nameLabel.snp.makeConstraints {
            $0.verticalEdges.leading.equalToSuperview().inset(20)
        }
        
        countLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(nameLabel)
        }
    }
    
    func bind(folder: Folder) {
        nameLabel.text = folder.name
        countLabel.text = String(folder.wishList.count)
    }
}
