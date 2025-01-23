//
//  ProfileView.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit
import SnapKit
import Then

final class ProfileView: BaseView {
    
    // MARK: - properties
    let withdrawBarButtonItem = UIBarButtonItem().then {
        $0.style = .plain
        $0.title = "탈퇴하기"
    }
    
    let nicknameButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("닉네임", for: .normal)
        $0.tag = 0
    }
    
    private let nicknameLabel = UILabel().then {
        $0.text = "NO NAME"
        $0.textColor = .lightGray
        $0.textAlignment = .right
    }
    
    let birthdayButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("생일", for: .normal)
        $0.tag = 1
    }
    
    private let birthdayLabel = UILabel().then {
        $0.text = "NO DATE"
        $0.textColor = .lightGray
        $0.textAlignment = .right
    }
    
    let levelButton = UIButton().then {
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("레벨", for: .normal)
        $0.tag = 2
    }
    
    private let levelLabel = UILabel().then {
        $0.text = "NO LEVEL"
        $0.textColor = .lightGray
        $0.textAlignment = .right
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        addSubview(nicknameButton)
        addSubview(nicknameLabel)
        addSubview(birthdayButton)
        addSubview(birthdayLabel)
        addSubview(levelButton)
        addSubview(levelLabel)
    }
    
    override func configureConstraints() {
        nicknameButton.snp.makeConstraints {
            $0.leading.top.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            $0.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            $0.height.equalTo(50)
        }
        
        birthdayButton.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).offset(24)
            $0.top.equalTo(nicknameButton.snp.bottom).offset(24)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
        
        birthdayLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            $0.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            $0.height.equalTo(50)
        }
        
        levelButton.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).offset(24)
            $0.top.equalTo(birthdayButton.snp.bottom).offset(24)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
        
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(24)
            $0.leading.equalTo(levelButton.snp.trailing).offset(24)
            $0.height.equalTo(50)
        }
    }
}
