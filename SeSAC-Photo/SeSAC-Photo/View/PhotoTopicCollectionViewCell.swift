//
//  PhotoTopicCollectionViewCell.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/20/25.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class PhotoTopicCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - properties
    static let identifier = "PhotoTopicCollectionViewCell"
    
    private let photoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
    }
    
    private let likeButton = UIButton()
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        likeButton.configuration = nil
    }
    
    // MARK: - methods
    override func configureUI() {
        configureLikeButton()
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(likeButton)
    }
    
    override func configureConstraints() {
        photoImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
        }
    }
    
    func configureLikeButton(like: Int? = 0) {
        var config = UIButton.Configuration.filled()
        config.title = String((like ?? 0).formatted(.number))
        config.image = UIImage(systemName: "star.fill")?.resize(width: 15, height: 13).withTintColor(UIColor(red: 236/255, green: 216/255, blue: 125/255, alpha: 1))
        config.imagePadding = 4
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor(red: 81/255, green: 89/255, blue: 86/255, alpha: 1)
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 11)
        config.background.cornerRadius = 14
        likeButton.configuration = config
    }
    
    func bind(photo: Photo?) {
        configureLikeButton(like: photo?.likes)
        
        guard let url = photo?.urls?.small else { return }
        photoImageView.kf.setImage(with: URL(string: url))
    }
}
