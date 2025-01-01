//
//  ProfileViewController.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/1/25.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var userActionButtons: [UIButton]!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet var boundaryView: UIView!
    @IBOutlet var personalFeatureButtons: [UIButton]!
    
    private let userActionButtonsImageArray = [UIImage(systemName: "gift"), UIImage(systemName: "die.face.5"), UIImage(systemName: "gearshape")]
    private let personalFeatureButtonsImageArray = [UIImage(systemName: "message.fill"), UIImage(systemName: "pencil"), UIImage(systemName: "paragraph")]
    private let personalFeatureButtonsTextArray = ["나와의 채팅", "프로필 편집", "카카오스토리"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureButton()
        configureLabel()
    }
    
    private func configureView() {
        view.backgroundColor = .lightGray
        boundaryView.backgroundColor = .white
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "xmark")?.resize(width: 18, height: 16).withTintColor(.white)
        config.baseBackgroundColor = .clear
        cancelButton.configuration = config
        
        userActionButtons.enumerated().forEach { (i, e) in
            config = UIButton.Configuration.filled()
            config.image = userActionButtonsImageArray[i]
            config.baseBackgroundColor = .clear
            e.configuration = config
        }
        
        config = UIButton.Configuration.filled()
        config.image = ._2.resize(width: 120, height: 120)
        config.baseBackgroundColor = .clear
        profileImageButton.contentMode = .scaleAspectFit
        profileImageButton.configuration = config
        profileImageButton.clipsToBounds = true
        profileImageButton.layer.cornerRadius = 50
        
        personalFeatureButtons.enumerated().forEach { (i, e) in
            config = UIButton.Configuration.filled()
            config.title = personalFeatureButtonsTextArray[i]
            config.image = personalFeatureButtonsImageArray[i]
            config.imagePadding = 16
            config.imagePlacement = .top
            config.baseBackgroundColor = .clear
            config.attributedTitle?.font = UIFont.systemFont(ofSize: 11, weight: .regular)
            e.configuration = config
        }
    }
    
    private func configureLabel() {
        nicknameLabel.text = "Jeong"
        nicknameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nicknameLabel.textColor = .white
        nicknameLabel.textAlignment = .center
        
        contentLabel.text = "2025년에도 화이팅!"
        contentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        contentLabel.textColor = .white
        contentLabel.numberOfLines = 2
        contentLabel.textAlignment = .center
    }
}
