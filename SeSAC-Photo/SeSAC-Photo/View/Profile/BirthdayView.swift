//
//  BirthdayView.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit
import SnapKit
import Then

final class BirthdayView: BaseView {
    
    // MARK: - properties
    let okBarButtonItem = UIBarButtonItem().then {
        $0.style = .plain
        $0.title = "확인"
    }
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
    }
    
    // MARK: - methods
    override func configureUI() {
        backgroundColor = .white
    }
    
    override func configureHierarchy() {
        addSubview(datePicker)
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints {
            $0.centerX.top.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureData(date: Date?) {
        datePicker.date = date ?? Date()
    }
}
