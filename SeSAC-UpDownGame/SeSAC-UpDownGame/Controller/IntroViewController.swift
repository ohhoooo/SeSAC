//
//  IntroViewController.swift
//  SeSAC-UpDownGame
//
//  Created by 김정호 on 1/9/25.
//

import UIKit

final class IntroViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var introImageView: UIImageView!
    @IBOutlet private weak var maxNumberTextField: UITextField!
    @IBOutlet private weak var textFieldBasedView: UIView!
    @IBOutlet private weak var startButton: UIButton!
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureLabel()
        configureButton()
        configureImageView()
        configureTextField()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(red: 193/255, green: 218/255, blue: 255/255, alpha: 1)
        
        textFieldBasedView.backgroundColor = .white
    }
    
    private func configureLabel() {
        titleLabel.text = "UP DOWN"
        titleLabel.font = .systemFont(ofSize: 44, weight: .heavy)
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "GAME"
        subtitleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        subtitleLabel.textAlignment = .center
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.title = "시작하기"
        config.cornerStyle = .fixed
        config.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 0)
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.attributedTitle?.font = .boldSystemFont(ofSize: 16)
        config.background.cornerRadius = 0
        startButton.configuration = config
    }
    
    private func configureImageView() {
        introImageView.image = .emotion1
        introImageView.contentMode = .scaleAspectFit
    }
    
    private func configureTextField() {
        maxNumberTextField.font = .systemFont(ofSize: 22, weight: .bold)
        maxNumberTextField.borderStyle = .none
        maxNumberTextField.placeholder = "최대 숫자를 입력하세요."
        maxNumberTextField.keyboardType = .numberPad
    }
}
