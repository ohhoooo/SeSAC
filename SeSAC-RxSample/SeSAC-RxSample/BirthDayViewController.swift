//
//  BirthDayViewController.swift
//  SeSAC-RxSample
//
//  Created by 김정호 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class BirthDayViewController: UIViewController {
    
    // MARK: - properties
    private let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2023년"
        label.textColor = UIColor.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "33월"
        label.textColor = UIColor.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "99일"
        label.textColor = UIColor.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    private let nextButton = PointButton(title: "가입하기")
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        configureLayout()
        configure()
    }
    
    // MARK: - methods
    private func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private func configure() {
        let observable = birthDayPicker.rx.date
        
        observable.map { $0.description.components(separatedBy: "-")[0] + "년" }
            .bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        observable.map { $0.description.components(separatedBy: "-")[1] + "월" }
            .bind(to: monthLabel.rx.text)
            .disposed(by: disposeBag)
        
        observable.map { $0.description.components(separatedBy: "-")[2].components(separatedBy: " ")[0] + "일" }
            .bind(to: dayLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
