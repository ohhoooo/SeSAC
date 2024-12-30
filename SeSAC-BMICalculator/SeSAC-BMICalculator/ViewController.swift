//
//  ViewController.swift
//  SeSAC-BMICalculator
//
//  Created by 김정호 on 12/30/24.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var textFieldArray: [UITextField]!
    @IBOutlet weak var randomBMICalculatorButton: UIButton!
    @IBOutlet weak var resultButton: UIButton!
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureLabel()
        configureImageView()
        configureTextField()
        configureButton()
    }
    
    private func configureLabel() {
        titleLabel.configureLabel(text: "BMI Calculator", font: .systemFont(ofSize: 24, weight: .bold))
        contentLabel.configureLabel(text: "당신의 BMI 지수를\n알려드릴게요.", font: .systemFont(ofSize: 15, weight: .regular), lines: 2)
        nicknameLabel.configureLabel(text: "닉네임이 어떻게 되시나요?", font: .systemFont(ofSize: 14, weight: .regular))
        heightLabel.configureLabel(text: "키가 어떻게 되시나요?", font: .systemFont(ofSize: 14, weight: .regular))
        weightLabel.configureLabel(text: "몸무게는 어떻게 되시나요?", font: .systemFont(ofSize: 14, weight: .regular))
    }
    
    private func configureImageView() {
        imageView.image = .image
    }
    
    private func configureTextField() {
        textFieldArray.forEach {
            $0.layer.borderWidth = 1
            $0.layer.cornerRadius = 16
            $0.clipsToBounds = true
        }
    }
    
    private func configureButton() {
        randomBMICalculatorButton.configureButton(title: "랜덤으로 BMI 계산하기",
                                            font: .systemFont(ofSize: 13, weight: .semibold),
                                            foregroundColor: UIColor(red: 155/255, green: 82/255, blue: 78/255, alpha: 1))
        randomBMICalculatorButton.configuration?.titleAlignment = .trailing
        
        resultButton.configureButton(title: "결과 확인",
                                font: .systemFont(ofSize: 18, weight: .regular),
                                cornerRadius: 14,
                                clipsToBounds: true,
                                foregroundColor: .white,
                                backgroundColor: UIColor(red: 121/255, green: 35/255, blue: 160/255, alpha: 1))
        resultButton.configuration?.contentInsets = .init(top: 10, leading: 0, bottom: 10, trailing: 0)
    }
}

extension UILabel {
    func configureLabel(text: String?, font: UIFont, lines: Int = 1) {
        self.text = text
        self.font = font
        self.numberOfLines = lines
    }
}

extension UIButton {
    func configureButton(title: String,
                        font: UIFont,
                        cornerRadius: CGFloat = 0.0,
                        clipsToBounds: Bool = false,
                        foregroundColor: UIColor = .black,
                        backgroundColor: UIColor? = nil) {
        let attributes: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: foregroundColor]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        self.setAttributedTitle(attributedTitle, for: .normal)
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
    }
}
