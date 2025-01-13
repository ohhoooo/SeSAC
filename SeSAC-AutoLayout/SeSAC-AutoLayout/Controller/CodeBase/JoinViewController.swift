//
//  JoinViewController.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/13/25.
//

import UIKit
import SnapKit

final class JoinViewController: UIViewController {
    
    // MARK: - properties
    private let titleLabel = {
        let label = UILabel()
        label.text = "JEONGFLIX"
        label.font = .systemFont(ofSize: 28, weight: .black)
        label.textColor = UIColor(red: 236/255, green: 83/255, blue: 66/255, alpha: 1)
        return label
    }()
    
    private lazy var emailTextField = {
        let tf = UITextField()
        tf.configureTextField(placeholder: placeholderArray[0], index: 0)
        return tf
    }()
    
    private lazy var passwordTextField = {
        let tf = UITextField()
        tf.configureTextField(placeholder: placeholderArray[1], index: 1)
        return tf
    }()
    
    private lazy var nicknameTextField = {
        let tf = UITextField()
        tf.configureTextField(placeholder: placeholderArray[2], index: 2)
        return tf
    }()
    
    private lazy var locationTextField = {
        let tf = UITextField()
        tf.configureTextField(placeholder: placeholderArray[3], index: 3)
        return tf
    }()
    
    private lazy var referenceTextField = {
        let tf = UITextField()
        tf.configureTextField(placeholder: placeholderArray[4], index: 4)
        return tf
    }()
    
    private let textFieldStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 14
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private let joinButton = {
        let btn = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .black), .foregroundColor: UIColor.black]
        let attributedTitle = NSAttributedString(string: "회원가입", attributes: attributes)
        btn.setAttributedTitle(attributedTitle, for: .normal)
        btn.clipsToBounds = true
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    private let additionalInformationLabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let additionalInformationSwitch = {
        let sw = UISwitch()
        sw.onTintColor = UIColor(red: 207/255, green: 79/255, blue: 64/255, alpha: 1)
        sw.backgroundColor = .lightGray
        sw.layer.cornerRadius = 16
        return sw
    }()
    
    private let additionalInformationStackView = {
        let sv = UIStackView()
        sv.spacing = 64
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        return sv
    }()
    
    private let placeholderArray = ["이메일 주소 또는 전화번호", "비밀번호", "닉네임", "위치", "추천 코드 입력"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        configureConstraint()
    }
    
    // MARK: - methods
    private func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(emailTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        textFieldStackView.addArrangedSubview(nicknameTextField)
        textFieldStackView.addArrangedSubview(locationTextField)
        textFieldStackView.addArrangedSubview(referenceTextField)
        view.addSubview(joinButton)
        view.addSubview(additionalInformationStackView)
        additionalInformationStackView.addArrangedSubview(additionalInformationLabel)
        additionalInformationStackView.addArrangedSubview(additionalInformationSwitch)
    }
    
    private func configureConstraint() {
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.2)
            $0.centerX.equalToSuperview()
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.8)
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        [emailTextField, passwordTextField, nicknameTextField, locationTextField, referenceTextField].forEach { textField in
            textField.snp.makeConstraints {
                $0.height.equalTo(34)
            }
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(48)
        }
        
        additionalInformationStackView.snp.makeConstraints {
            $0.top.equalTo(joinButton.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
    }
}

// MARK: - extensions
extension UITextField {
    func configureTextField(placeholder: String, index: Int) {
        self.font = .systemFont(ofSize: 14)
        self.tintColor = .white
        self.textColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        self.clipsToBounds = true
        self.textAlignment = .center
        self.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
        self.isSecureTextEntry = (index == 1) ? true : false
        self.layer.cornerRadius = 6
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
    }
}
