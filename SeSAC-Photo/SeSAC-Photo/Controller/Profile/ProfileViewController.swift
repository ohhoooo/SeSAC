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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        profileView.withdrawBarButtonItem.target = self
        profileView.withdrawBarButtonItem.action = #selector(tappedWithdrawBarButtonItem)
        
        profileView.nicknameButton.addTarget(self, action: #selector(tappedChangeButton), for: .touchUpInside)
        profileView.birthdayButton.addTarget(self, action: #selector(tappedChangeButton), for: .touchUpInside)
        profileView.levelButton.addTarget(self, action: #selector(tappedChangeButton), for: .touchUpInside)
    }
    
    private func configureNavigation() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = profileView.withdrawBarButtonItem
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc
    private func tappedChangeButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            navigationController?.pushViewController(NicknameViewController(), animated: true)
        case 1:
            navigationController?.pushViewController(BirthdayViewController(), animated: true)
        default:
            navigationController?.pushViewController(LevelViewController(), animated: true)
        }
    }
    
    @objc
    private func tappedWithdrawBarButtonItem() {
        print(#function)
    }
}
