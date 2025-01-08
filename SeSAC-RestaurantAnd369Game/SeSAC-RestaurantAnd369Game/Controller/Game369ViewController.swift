//
//  Game369ViewController.swift
//  SeSAC-RestaurantAnd369Game
//
//  Created by 김정호 on 1/8/25.
//

import UIKit

final class Game369ViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameBasedView: UIView!
    @IBOutlet weak var gameTextField: UITextField!
    @IBOutlet weak var gameTextView: UITextView!
    @IBOutlet weak var gameClapCountLabel: UILabel!
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureLabel()
        configureTextField()
        configureTextView()
    }
    
    private func configureView() {
        gameBasedView.layer.borderWidth = 1
    }
    
    private func configureLabel() {
        gameTitleLabel.text = "369 게임"
        gameTitleLabel.font = .boldSystemFont(ofSize: 36)
        
        gameClapCountLabel.text = ""
        gameClapCountLabel.font = .boldSystemFont(ofSize: 36)
        gameClapCountLabel.numberOfLines = 0
        gameClapCountLabel.textAlignment = .center
    }
    
    private func configureTextField() {
        gameTextField.font = .systemFont(ofSize: 24)
        gameTextField.borderStyle = .none
        gameTextField.placeholder = "최대 숫자를 입력해주세요"
        gameTextField.textAlignment = .center
    }
    
    private func configureTextView() {
        gameTextView.font = .systemFont(ofSize: 20)
        gameTextView.textColor = .systemGray2
        gameTextView.isEditable = false
        gameTextView.textAlignment = .center
    }
}
