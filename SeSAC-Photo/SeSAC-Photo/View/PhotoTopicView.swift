//
//  PhotoTopicView.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/20/25.
//

import UIKit
import SnapKit
import Then

final class PhotoTopicView: BaseView {
    
    // MARK: - properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let goldenHourLabel = UILabel().then {
        $0.text = "골든 아워"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    lazy var goldenHourCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(PhotoTopicCollectionViewCell.self, forCellWithReuseIdentifier: PhotoTopicCollectionViewCell.identifier)
    }
    
    private let businessWorkLabel = UILabel().then {
        $0.text = "비즈니스 및 업무"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    lazy var businessWorkCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(PhotoTopicCollectionViewCell.self, forCellWithReuseIdentifier: PhotoTopicCollectionViewCell.identifier)
    }
    
    private let architectureInteriorLabel = UILabel().then {
        $0.text = "건축 및 인테리어"
        $0.font = .boldSystemFont(ofSize: 20)
    }
    
    lazy var architectureInteriorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(PhotoTopicCollectionViewCell.self, forCellWithReuseIdentifier: PhotoTopicCollectionViewCell.identifier)
    }
    
    // MARK: - methods
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(goldenHourLabel)
        contentView.addSubview(goldenHourCollectionView)
        contentView.addSubview(businessWorkLabel)
        contentView.addSubview(businessWorkCollectionView)
        contentView.addSubview(architectureInteriorLabel)
        contentView.addSubview(architectureInteriorCollectionView)
    }
    
    override func configureConstraints() {
        scrollView.snp.makeConstraints {
            $0.verticalEdges.equalTo(layoutMarginsGuide)
            $0.horizontalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.snp.width)
            $0.verticalEdges.equalTo(scrollView)
        }
        
        goldenHourLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.leading.equalTo(16)
        }
        
        goldenHourCollectionView.snp.makeConstraints {
            $0.top.equalTo(goldenHourLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(240)
        }
        
        businessWorkLabel.snp.makeConstraints {
            $0.top.equalTo(goldenHourCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(16)
        }
        
        businessWorkCollectionView.snp.makeConstraints {
            $0.top.equalTo(businessWorkLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(240)
        }
        
        architectureInteriorLabel.snp.makeConstraints {
            $0.top.equalTo(businessWorkCollectionView.snp.bottom).offset(20)
            $0.leading.equalTo(16)
        }
        
        architectureInteriorCollectionView.snp.makeConstraints {
            $0.top.equalTo(architectureInteriorLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(contentView)
            $0.height.equalTo(240)
        }
    }
}

// MARK: - extensions
extension PhotoTopicView {
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let lineSpacing: CGFloat = 8
        let horizontalInset: CGFloat = 16
        let interitemSpacing: CGFloat = 8
        let width = (UIScreen.main.bounds.size.width - (horizontalInset * 2) - interitemSpacing) / 2.0
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        
        return layout
    }
}
