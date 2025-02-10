//
//  PhotoDetailView.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/20/25.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class PhotoDetailView: BaseView {
    
    // MARK: - properties
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 18
    }
    
    private let nicknameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11)
    }
    
    private let dateLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 10)
    }
    
    private let photoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let infoTitleLabel = UILabel().then {
        $0.text = "정보"
        $0.font = .systemFont(ofSize: 18, weight: .black)
    }
    
    private let sizeTitleLabel = UILabel().then {
        $0.text = "크기"
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    private let sizeContentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }
    
    private let sizeStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .equalCentering
    }
    
    private let viewTitleLabel = UILabel().then {
        $0.text = "조회수"
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    private let viewContentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }
    
    private let viewStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .equalCentering
    }
    
    private let downloadTitleLabel = UILabel().then {
        $0.text = "다운로드"
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    private let downloadContentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }
    
    private let downloadStackView = UIStackView().then {
        $0.alignment = .center
        $0.distribution = .equalCentering
    }
    
    private let infoContentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    private let infoStackView = UIStackView().then {
        $0.spacing = 80
        $0.alignment = .top
        $0.distribution = .fillProportionally
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(nicknameLabel)
        addSubview(dateLabel)
        addSubview(photoImageView)
        addSubview(infoStackView)
        sizeStackView.addArrangedSubview(sizeTitleLabel)
        sizeStackView.addArrangedSubview(sizeContentLabel)
        viewStackView.addArrangedSubview(viewTitleLabel)
        viewStackView.addArrangedSubview(viewContentLabel)
        downloadStackView.addArrangedSubview(downloadTitleLabel)
        downloadStackView.addArrangedSubview(downloadContentLabel)
        infoContentStackView.addArrangedSubview(sizeStackView)
        infoContentStackView.addArrangedSubview(viewStackView)
        infoContentStackView.addArrangedSubview(downloadStackView)
        infoStackView.addArrangedSubview(infoTitleLabel)
        infoStackView.addArrangedSubview(infoContentStackView)
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(36)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView).offset(4)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(nicknameLabel)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(photoImageView.snp.width)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func bindPhoto(photo: Photo?) {
        nicknameLabel.text = photo?.user?.name
        dateLabel.text = photo?.createdAt?.format()
        sizeContentLabel.text = "\(photo?.width ?? 0) x \(photo?.height ?? 0)"
        
        if let profileUrl = photo?.user?.profileImage?.medium {
            profileImageView.kf.setImage(with: URL(string: profileUrl))
        } else {
            profileImageView.image = UIImage(systemName: "photo")
        }
        
        if let photoUrl = photo?.urls?.raw {
            photoImageView.kf.setImage(with: URL(string: photoUrl))
        } else {
            photoImageView.image = UIImage(systemName: "photo")
        }
    }
    
    func bindPhotoStatistic(photoStatistic: PhotoStatistic?) {
        viewContentLabel.text = String((photoStatistic?.views?.total ?? 0).formatted(.number))
        downloadContentLabel.text = String((photoStatistic?.downloads?.total ?? 0).formatted(.number))
    }
}
