//
//  BaseCollectionViewCell.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/16/25.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, BaseViewProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    
    func configureHierarchy() { }
    
    func configureConstraints() { }
}
