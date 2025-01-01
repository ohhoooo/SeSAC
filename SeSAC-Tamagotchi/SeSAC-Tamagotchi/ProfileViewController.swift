//
//  ProfileViewController.swift
//  SeSAC-Tamagotchi
//
//  Created by 김정호 on 1/2/25.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var boundaryView: UIView!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var textFieldBoundaryView: UIView!
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigation()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureTextField()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(red: 246/255, green: 252/255, blue: 252/255, alpha: 1)
        boundaryView.backgroundColor = UIColor(red: 228/255, green: 233/255, blue: 233/255, alpha: 1)
        textFieldBoundaryView.backgroundColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)
    }
    
    private func configureTextField() {
        nicknameTextField.font = .systemFont(ofSize: 14, weight: .bold)
        nicknameTextField.placeholder = "닉네임을 입력하세요."
        nicknameTextField.borderStyle = .none
        nicknameTextField.textColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)
    }
    
    private func configureNavigation() {
        let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""
        navigationItem.title = "\(nickname)님 이름 정하기"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)]
        
        saveBarButtonItem.title = "저장"
        saveBarButtonItem.tintColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)
    }
    
    @IBAction func tappedSaveBarButtonItem(_ sender: UIBarButtonItem) {
        guard let count = nicknameTextField.text?.count, count > 1 && count < 7 else {
            presentAlert(title: "알림", message: "2글자 이상 6글자 이하까지 가능합니다!")
            return
        }
        
        presentAlert(title: "알림", message: "성공적으로 저장하였습니다!")
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "nickname")
    }
    
    private func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let check = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(check)
        present(alert, animated: true)
    }
}
