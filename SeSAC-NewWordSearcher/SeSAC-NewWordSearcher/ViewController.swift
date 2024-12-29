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
    
    private let newWordArray = [""]
    
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
}
