//
//  SearchViewController.swift
//  SeSAC-Movie
//
//  Created by 김정호 on 12/29/24.
//

import UIKit

final class SearchViewController: UIViewController {

    // MARK: - properties
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var alternativeMessageLabel: UILabel!
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        buttonArray.forEach {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 16
        }
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        changeButtonProperty(button: sender)
        changeErrorMessageLabel(tag: sender.tag)
    }
    
    private func changeButtonProperty(button: UIButton) {
        buttonArray.forEach {
            $0.backgroundColor = .clear
            $0.setTitleColor(.white, for: .normal)
        }
        
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
    }
    
    private func changeErrorMessageLabel(tag: Int) {
        switch tag {
        case 0:
            errorMessageLabel.text = "이런! 찾으시는 작품이 없습니다."
        case 1:
            errorMessageLabel.text = "이런! 찾으시는 인기 콘텐츠가 없습니다."
        default:
            errorMessageLabel.text = "이런! 찾으시는 시리즈가 없습니다."
        }
    }
}
