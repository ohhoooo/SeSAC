//
//  ProfileViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit

protocol LevelDelegate {
    func postLevel(level: Int)
}

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
        
        profileView.saveButton.addTarget(self, action: #selector(tappedSaveButton), for: .touchUpInside)
    }
    
    override func bind() {
        profileView.configureNicknameLabel(nickname: UserDefaults.standard.string(forKey: "nickname"))
        profileView.configureBirthdayLabel(birthday: UserDefaults.standard.object(forKey: "birthday") as? Date)
        profileView.configureLevelLabel(level: UserDefaults.standard.string(forKey: "level"))
    }
    
    private func configureNavigation() {
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = profileView.withdrawBarButtonItem
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc
    private func tappedWithdrawBarButtonItem() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
        window.rootViewController = OnboardingViewController()
        window.makeKeyAndVisible()
        
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    
    @objc
    private func tappedChangeButton(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let nicknameVC = NicknameViewController()
            nicknameVC.nickname = profileView.fetchNicknameLabel()
            nicknameVC.completion = { [weak self] nickname in
                self?.profileView.configureNicknameLabel(nickname: nickname)
            }
            
            navigationController?.pushViewController(nicknameVC, animated: true)
        case 1:
            let birthdayVC = BirthdayViewController()
            birthdayVC.birthday = profileView.fetchBirthdayLabel()
            NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: NSNotification.Name("date"), object: nil)
            
            navigationController?.pushViewController(birthdayVC, animated: true)
        default:
            let levelVC = LevelViewController()
            levelVC.level = profileView.fetchLevelLabel()
            levelVC.delegate = self
            
            navigationController?.pushViewController(levelVC, animated: true)
        }
    }
    
    @objc
    private func receivedNotification(value: NSNotification) {
        if let date = value.userInfo!["date"] as? Date {
            profileView.configureBirthdayLabel(birthday: date)
        }
    }
    
    @objc
    private func tappedSaveButton() {
        if profileView.isSavable() {
            UserDefaults.standard.set(profileView.fetchNicknameLabel(), forKey: "nickname")
            UserDefaults.standard.set(profileView.fetchBirthdayLabel(), forKey: "birthday")
            UserDefaults.standard.set(profileView.fetchLevelLabel(), forKey: "level")
        }
    }
}

// MARK: - extensions
extension ProfileViewController: LevelDelegate {
    func postLevel(level: Int) {
        profileView.configureLevelLabel(level: String(level))
    }
}
