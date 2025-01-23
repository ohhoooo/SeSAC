//
//  ProfileViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit

final class ProfileViewController: BaseViewController {
    
    // MARK: - properties
    private let profileView = ProfileView()
    
    // MARK: - life cycles
    override func loadView() {
        view = profileView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureAddTarget() {
        profileView.nicknameButton.addTarget(self, action: #selector(tappedChangeButton), for: .touchUpInside)
        profileView.birthdayButton.addTarget(self, action: #selector(tappedChangeButton), for: .touchUpInside)
        profileView.levelButton.addTarget(self, action: #selector(tappedChangeButton), for: .touchUpInside)
    }
    
    private func configureNavigation() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = profileView.withdrawBarButtonItem
        navigationController?.navigationBar.tintColor = .black
        
        profileView.withdrawBarButtonItem.target = self
        profileView.withdrawBarButtonItem.action = #selector(tappedWithdrawBarButtonItem)
    }
    
    @objc
    private func tappedChangeButton(_ sender: UIButton) {
        print(#function)
    }
    
    @objc
    private func tappedWithdrawBarButtonItem() {
        print(#function)
    }
}
