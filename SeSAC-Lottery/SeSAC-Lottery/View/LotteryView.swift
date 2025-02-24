//
//  LotteryView.swift
//  SeSAC-Lottery
//
//  Created by 김정호 on 1/14/25.
//

import UIKit
import SnapKit
import Then

final class LotteryView: UIView {
    
    // MARK: - properties
    private lazy var drwNoSelectTextField = UITextField().then {
        $0.font = .systemFont(ofSize: 18)
        $0.inputView = pickerView
        $0.borderStyle = .line
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray5.cgColor
        $0.layer.cornerRadius = 8
    }
    
    let pickerView = UIPickerView()
    
    private let guideLabel = UILabel().then {
        $0.text = "당첨번호 안내"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    private let drwNoDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .semibold)
        $0.textColor = .systemGray
    }
    
    private let basedView = UIView().then {
        $0.backgroundColor = .systemGray4
    }
    
    private let drwNoResultLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(red: 254/255, green: 202/255, blue: 5/255, alpha: 1)
    }
    
    private let drwtNo1Label = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(red: 254/255, green: 203/255, blue: 0, alpha: 1)
    }
    
    private let drwtNo2Label = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(red: 106/255, green: 198/255, blue: 241/255, alpha: 1)
    }
    
    private let drwtNo3Label = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(red: 106/255, green: 198/255, blue: 241/255, alpha: 1)
    }
    
    private let drwtNo4Label = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(red: 254/255, green: 113/255, blue: 114/255, alpha: 1)
    }
    
    private let drwtNo5Label = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(red: 254/255, green: 113/255, blue: 114/255, alpha: 1)
    }
    
    private let drwtNo6Label = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
    }
    
    private let plusImageBasedView = UIView()
    
    private let plusImageView = UIImageView().then {
        $0.image = UIImage(systemName: "plus")?.resize(width: 12, height: 12)
        $0.tintColor = .black
        $0.contentMode = .scaleToFill
    }
    
    private let bnusNoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
    }
    
    private let drwtNoStackView = UIStackView().then {
        $0.spacing = 6
        $0.alignment = .fill
        $0.distribution = .equalSpacing
    }
    
    private let bnusLabel = UILabel().then {
        $0.text = "보너스"
        $0.font = .systemFont(ofSize: 11, weight: .black)
        $0.textColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
        $0.textAlignment = .center
    }
    
    let observableButton = UIButton().then {
        $0.setTitle("Observable Button", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    let singleButton = UIButton().then {
        $0.setTitle("Single Button", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    // MARK: - life cycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    private func configureUI() {
        backgroundColor = .white
    }
    
    private func configureHierarchy() {
        addSubview(drwNoSelectTextField)
        addSubview(guideLabel)
        addSubview(drwNoDateLabel)
        addSubview(basedView)
        addSubview(drwNoResultLabel)
        addSubview(drwtNoStackView)
        addSubview(bnusLabel)
        addSubview(observableButton)
        addSubview(singleButton)
        plusImageBasedView.addSubview(plusImageView)
        drwtNoStackView.addArrangedSubview(drwtNo1Label)
        drwtNoStackView.addArrangedSubview(drwtNo2Label)
        drwtNoStackView.addArrangedSubview(drwtNo3Label)
        drwtNoStackView.addArrangedSubview(drwtNo4Label)
        drwtNoStackView.addArrangedSubview(drwtNo5Label)
        drwtNoStackView.addArrangedSubview(drwtNo6Label)
        drwtNoStackView.addArrangedSubview(plusImageBasedView)
        drwtNoStackView.addArrangedSubview(bnusNoLabel)
    }
    
    private func configureConstraints() {
        drwNoSelectTextField.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(44)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(drwNoSelectTextField.snp.bottom).offset(28)
            $0.leading.equalTo(basedView)
        }
        
        drwNoDateLabel.snp.makeConstraints {
            $0.trailing.equalTo(basedView)
            $0.centerY.equalTo(guideLabel)
        }
        
        basedView.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(1)
        }
        
        drwNoResultLabel.snp.makeConstraints {
            $0.top.equalTo(basedView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
        drwtNoStackView.snp.makeConstraints {
            $0.top.equalTo(drwNoResultLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
        }
        
        plusImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        bnusLabel.snp.makeConstraints {
            $0.top.equalTo(bnusNoLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(bnusNoLabel)
        }
        
        [drwtNo1Label, drwtNo2Label, drwtNo3Label, drwtNo4Label, drwtNo5Label, drwtNo6Label, plusImageBasedView, bnusNoLabel].forEach { view in
            view.snp.makeConstraints {
                $0.size.equalTo(40)
            }
        }
        
        observableButton.snp.makeConstraints {
            $0.top.equalTo(bnusLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        singleButton.snp.makeConstraints {
            $0.top.equalTo(bnusLabel.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}

// MARK: - extensions
extension LotteryView {
    func configureData(lottery: Lottery) {
        drwNoSelectTextField.text = String(lottery.drwNo)
        drwNoDateLabel.text = "\(lottery.drwNoDate) 추첨"
        drwNoResultLabel.text = "\(lottery.drwNo)회 당첨결과"
        let fontSize = UIFont.boldSystemFont(ofSize: 21)
        let attributedStr = NSMutableAttributedString(string: drwNoResultLabel.text!)
        attributedStr.addAttribute(.font, value: fontSize, range: (drwNoResultLabel.text! as NSString).range(of: "\(lottery.drwNo)회"))
        attributedStr.addAttribute(.foregroundColor, value: UIColor.black, range: (drwNoResultLabel.text! as NSString).range(of: "당첨결과"))
        drwNoResultLabel.attributedText = attributedStr
        drwtNo1Label.text = String(lottery.drwtNo1)
        drwtNo2Label.text = String(lottery.drwtNo2)
        drwtNo3Label.text = String(lottery.drwtNo3)
        drwtNo4Label.text = String(lottery.drwtNo4)
        drwtNo5Label.text = String(lottery.drwtNo5)
        drwtNo6Label.text = String(lottery.drwtNo6)
        bnusNoLabel.text = String(lottery.bnusNo)
    }
    
    func sizeCornerRadius() {
        [drwtNo1Label, drwtNo2Label, drwtNo3Label, drwtNo4Label, drwtNo5Label, drwtNo6Label, plusImageBasedView, bnusNoLabel].forEach {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = $0.frame.width / 2
        }
    }
}
