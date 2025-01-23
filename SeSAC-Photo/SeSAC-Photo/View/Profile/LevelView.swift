//
//  LevelView.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit
import SnapKit
import Then

final class LevelView: BaseView {
    
    // MARK: - properties
    let okBarButtonItem = UIBarButtonItem().then {
        $0.style = .plain
        $0.title = "확인"
    }
    
    let segmentedControl = UISegmentedControl(items: ["상", "중", "하"]).then {
        $0.selectedSegmentIndex = 0
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        addSubview(segmentedControl)
    }
    
    override func configureConstraints() {
        segmentedControl.snp.makeConstraints {
            $0.centerX.top.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(safeAreaLayoutGuide).inset(24)
        }
    }
}
