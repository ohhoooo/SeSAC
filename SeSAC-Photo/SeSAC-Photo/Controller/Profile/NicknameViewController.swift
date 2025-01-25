//
//  NicknameViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit

final class NicknameViewController: BaseViewController {
    
    // MARK: - properties
    private let nicknameView = NicknameView()
    
    var nickname: String?
    var completion: ((String?) -> Void)?
    
    // MARK: - life cycles
    override func loadView() {
        view = nicknameView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureAddTarget() {
        nicknameView.okBarButtonItem.target = self
        nicknameView.okBarButtonItem.action = #selector(tappedOkBarButtonItem)
    }
    
    override func bind() {
        nicknameView.configureData(nickname: nickname)
    }
    
    private func configureNavigation() {
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = nicknameView.okBarButtonItem
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc
    private func tappedOkBarButtonItem() {
        completion?(nicknameView.textField.text)
        
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        completion?(nicknameView.textField.text)
    }
}
