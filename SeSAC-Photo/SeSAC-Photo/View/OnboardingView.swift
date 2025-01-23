//
//  OnboardingView.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/24/25.
//

import UIKit
import SnapKit
import Then

final class OnboardingView: BaseView {
    
    // MARK: - properties
    let button = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.setTitleColor(.darkGray, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .darkGray
    }
    
    override func configureHierarchy() {
        addSubview(button)
    }
    
    override func configureConstraints() {
        button.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
        }
    }
}
