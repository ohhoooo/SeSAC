//
//  NicknameView.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit
import SnapKit
import Then

final class NicknameView: BaseView {
    
    // MARK: - properties
    let okBarButtonItem = UIBarButtonItem().then {
        $0.style = .plain
        $0.title = "확인"
    }
    
    let textField = UITextField().then {
        $0.placeholder = "닉네임을 입력해주세요"
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        addSubview(textField)
    }
    
    override func configureConstraints() {
        textField.snp.makeConstraints {
            $0.centerX.top.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
    
    func configureData(nickname: String?) {
        textField.text = nickname
    }
}
