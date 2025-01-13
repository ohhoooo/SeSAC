//
//  CodeBaseViewController.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/13/25.
//

import UIKit

final class CodeBaseViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet var buttonArray: [UIButton]!
    
    private let buttonTitle = ["회원 가입 화면", "지불 인증 화면", "영화 검색 화면"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButton()
    }
    
    // MARK: - methods
    private func configureButton() {
        buttonArray.enumerated().forEach { (i, e) in
            e.setTitle(buttonTitle[i], for: .normal)
        }
    }
    
    @IBAction func tappedButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let joinVC = JoinViewController()
            present(joinVC, animated: true)
        case 1:
            let paymentVC = PaymentViewController()
            present(paymentVC, animated: true)
        default:
            let movieSearchVC = MovieSearchViewController()
            present(movieSearchVC, animated: true)
        }
    }
}
