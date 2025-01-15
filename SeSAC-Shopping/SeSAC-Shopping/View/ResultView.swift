//
//  ResultView.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit
import SnapKit
import Then

final class ResultView: UIView {
    
    // MARK: - properties
    private let totalLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = UIColor(red: 68/255, green: 208/255, blue: 137/255, alpha: 1)
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
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
extension ResultView {
    private func configureUI() {
        backgroundColor = .white
    }
    
    private func configureHierarchy() {
        addSubview(totalLabel)
        addSubview(collectionView)
    }
    
    private func configureConstraints() {
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(12)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(4)
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
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
    
    func configureData(total: Int) {
        totalLabel.text = "\(total.formatted(.number)) 개의 검색 결과"
    }
}
