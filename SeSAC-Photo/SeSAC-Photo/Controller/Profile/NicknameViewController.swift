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
    
    private func configureNavigation() {
        navigationItem.title = "닉네임"
        navigationItem.rightBarButtonItem = nicknameView.okBarButtonItem
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc
    private func tappedOkBarButtonItem() {
        print(#function)
    }
}
