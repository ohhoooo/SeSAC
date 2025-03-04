//
//  ResultCollectionViewCell.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit
import Kingfisher
import SnapKit
import Then
import RxSwift
import RxCocoa

final class ResultCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - properties
    static let identifier = "ResultCollectionViewCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    let likeButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.baseForegroundColor = .red
        config.background.backgroundColor = .clear
        $0.configuration = config
    }
    
    private let mallLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
        $0.textColor = .gray
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .darkGray
        $0.numberOfLines = 2
    }
    
    private let priceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    var disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        mallLabel.text = nil
        titleLabel.text = nil
        priceLabel.text = nil
        likeButton.tag = 0
        
        disposeBag = DisposeBag()
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(mallLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    override func configureConstraints() {
        imageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }
        
        likeButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(imageView).inset(8)
        }
        
        mallLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(mallLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    func configureData(item: Item?) {
        guard let item else { return }
        
        mallLabel.text = item.mallName
        titleLabel.text = item.title?.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
        
        if let price = item.price, let intPrice = Int(price) {
            priceLabel.text = intPrice.formatted(.number)
        } else {
            priceLabel.text = "알수없음"
        }
        
        if let url = item.image {
            imageView.kf.setImage(with: URL(string: url))
        } else {
            imageView.image = UIImage(systemName: "photo")
        }
    }
    
    func bindLike(like: Bool) {
        likeButton.configuration?.image = UIImage(systemName: like ? "heart.fill" : "heart")
    }
}
