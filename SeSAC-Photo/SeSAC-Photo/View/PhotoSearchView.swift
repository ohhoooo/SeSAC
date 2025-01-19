//
//  PhotoSearchView.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import UIKit
import SnapKit
import Then

final class PhotoSearchView: BaseView {
    
    // MARK: - properties
    let searchBar = UISearchBar().then {
        $0.placeholder = "키워드 검색"
        $0.searchBarStyle = .minimal
    }
    
    private let dividerView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let orderButton = UIButton()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
        $0.register(PhotoSearchCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSearchCollectionViewCell.identifier)
    }
    
    private let guideLabel = UILabel().then {
        $0.text = "사진을 검색해보세요."
        $0.font = .systemFont(ofSize: 16, weight: .black)
        $0.textAlignment = .center
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
        
        changeOrderButton()
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(dividerView)
        addSubview(orderButton)
        addSubview(collectionView)
        addSubview(guideLabel)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        orderButton.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.height.equalTo(36)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(orderButton.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(orderButton.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func changeOrderButton(order: Order = .relevant) {
        var config = UIButton.Configuration.filled()
        config.title = order.toKorean
        config.image = UIImage(systemName: "increase.indent")?.resize(width: 19, height: 14)
        config.imagePadding = 4
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 14, weight: .black)
        config.background.strokeWidth = 0.5
        config.background.strokeColor = .systemGray4
        config.background.cornerRadius = 20
        orderButton.configuration = config
    }
}

// MARK: - extensions
extension PhotoSearchView {
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let lineSpacing: CGFloat = 4
        let interitemSpacing: CGFloat = 4
        let width = (UIScreen.main.bounds.size.width - interitemSpacing) / 2.0
        layout.itemSize = CGSize(width: width, height: width * 1.3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = interitemSpacing
        
        return layout
    }
}
