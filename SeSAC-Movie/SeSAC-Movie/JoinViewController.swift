//
//  JoinViewController.swift
//  SeSAC-Movie
//
//  Created by 김정호 on 12/26/24.
//

import UIKit

final class JoinViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var recommendationTextField: UITextField!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var additionalInformationLabel: UILabel!
    @IBOutlet weak var additionalInformationSwitch: UISwitch!
    
    private lazy var textFieldArray = [idTextField,
                                    passwordTextField,
                                    nicknameTextField,
                                    locationTextField,
                                    recommendationTextField]
    
    private let placeholderArray = ["이메일 주소 또는 전화번호",
                                "비밀번호",
                                "닉네임",
                                "위치",
                                "추천 코드 입력"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    func configureUI() {
        // View
        view.backgroundColor = .black
        
        // Label
        titleLabel.text = "JEONGFLIX"
        titleLabel.textColor = UIColor(red: 236/255, green: 83/255, blue: 66/255, alpha: 1)
        titleLabel.font = .systemFont(ofSize: 28, weight: .black)
        
        additionalInformationLabel.text = "추가 정보 입력"
        additionalInformationLabel.textColor = .white
        additionalInformationLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        
        // TextField
        textFieldArray.enumerated().forEach { (i, e) in
            e?.tintColor = .white
            e?.textColor = .white
            e?.textAlignment = .center
            e?.backgroundColor = UIColor(red: 85/255, green: 85/255, blue: 85/255, alpha: 1)
            e?.setPlaceholder(placeholder: placeholderArray[i], color: .white)
        }
        
        passwordTextField.isSecureTextEntry = true
        
        // Button
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .black),
                                                    .foregroundColor: UIColor.black]
        let attributedTitle = NSAttributedString(string: "회원가입", attributes: attributes)
        joinButton.setAttributedTitle(attributedTitle, for: .normal)
        joinButton.backgroundColor = .white
        joinButton.layer.cornerRadius = 6
        joinButton.clipsToBounds = true
        joinButton.configuration?.contentInsets = .init(top: 14, leading: 0, bottom: 14, trailing: 0)
        
        // Switch
        additionalInformationSwitch.onTintColor = UIColor(red: 207/255, green: 79/255, blue: 64/255, alpha: 1)
        additionalInformationSwitch.backgroundColor = .lightGray
        additionalInformationSwitch.layer.cornerRadius = 16
    }
    
    @IBAction func tappedJoinButton(_ sender: UIButton) {
        view.endEditing(true)
    }
}

// MARK: - extensions
extension UITextField {
    func setPlaceholder(placeholder: String, color: UIColor) {
        attributedPlaceholder = NSAttributedString(string: placeholder,
                                            attributes: [.foregroundColor: color])
    }
}
