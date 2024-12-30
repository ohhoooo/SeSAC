//
//  ViewController.swift
//  SeSAC-NewWordSearcher
//
//  Created by 김정호 on 12/30/24.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var textFieldBackgroundView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultBackgroundImageView: UIImageView!
    
    private let newWordArray: [String: String] = ["취존": "취향 존중",
                                            "JMT": "너무 맛있어",
                                            "정뚝떨": "정이 뚝 떨어진다",
                                            "자낳괴": "자본주의가 낳은 괴물",
                                            "낄끼빠빠": "낄 때 끼고 빠질 때 빠져라"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureTextField()
        configureButton()
        configureLabel()
        configureImageView()
    }
    
    private func configureView() {
        textFieldBackgroundView.layer.borderWidth = 2
    }
    
    private func configureTextField() {
        searchTextField.borderStyle = .none
        searchTextField.placeholder = "검색어를 입력하세요."
    }
    
    private func configureButton() {
        searchButton.setTitle("", for: .normal)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .white
        searchButton.backgroundColor = .black
    }
    
    private func configureLabel() {
        resultLabel.text = ""
    }
    
    private func configureImageView() {
        resultBackgroundImageView.image = .background
    }
    
    @IBAction func tappedTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func tappedTextFieldReturnKey(_ sender: UITextField) {
        searchNewWord(word: sender.text)
    }
    
    @IBAction func tappedSearchButton(_ sender: UIButton) {
        searchNewWord(word: searchTextField.text)
    }
    
    private func searchNewWord(word: String?) {
        if let word = word, let result = newWordArray[word] {
            resultLabel.text = result
        } else {
            resultLabel.text = "검색결과가 없습니다"
        }
    }
}
