//
//  ViewController.swift
//  SeSAC-Tamagotchi
//
//  Created by 김정호 on 1/2/25.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var profileBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var boundaryView: UIView!
    @IBOutlet weak var speechBubbleImageView: UIImageView!
    @IBOutlet weak var speechBubbleLabel: UILabel!
    @IBOutlet weak var tamagotchiImageView: UIImageView!
    @IBOutlet weak var nicknameBasedView: UIView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet var textFieldArray: [UITextField]!
    @IBOutlet var viewArray: [UIView]!
    @IBOutlet var buttonArray: [UIButton]!
    
    private let textFieldPlaceholderArray = ["밥주세용", "물주세용"]
    private let buttonTextArray = ["밥먹기", "물먹기"]
    private let buttonImageArray = [UIImage(systemName: "leaf.circle"), UIImage(systemName: "drop.circle")]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigation()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureLabel()
        configureButton()
        configureImageView()
        configureTextField()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(red: 246/255, green: 252/255, blue: 252/255, alpha: 1)
        
        boundaryView.backgroundColor = UIColor(red: 228/255, green: 233/255, blue: 233/255, alpha: 1)
        
        nicknameBasedView.clipsToBounds = true
        nicknameBasedView.layer.borderWidth = 1
        nicknameBasedView.layer.borderColor = UIColor(red: 135/255, green: 153/255, blue: 161/255, alpha: 1).cgColor
        nicknameBasedView.layer.cornerRadius = 4
        nicknameBasedView.backgroundColor = UIColor(red: 240/255, green: 249/255, blue: 249/255, alpha: 1)
        
        viewArray.forEach {
            $0.backgroundColor = .black
        }
    }
    
    private func configureLabel() {
        speechBubbleLabel.text = "복습 아직 안하셨다구요? 지금 잠이 오세여? 대장님??"
        speechBubbleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        speechBubbleLabel.textColor = UIColor(red: 86/255, green: 108/255, blue: 121/255, alpha: 1)
        speechBubbleLabel.numberOfLines = 3
        speechBubbleLabel.textAlignment = .center
        
        nicknameLabel.text = "방실방실 다마고치"
        nicknameLabel.font = .systemFont(ofSize: 14, weight: .bold)
        nicknameLabel.textColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)
        
        informationLabel.text = "LV1 · 밥알 0개 · 물방울 0개"
        informationLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        informationLabel.textColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)
    }
    
    private func configureButton() {
        buttonArray.enumerated().forEach { (i, e) in
            var config = UIButton.Configuration.filled()
            config.title = buttonTextArray[i]
            config.image = buttonImageArray[i]?.withTintColor(UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1))
            config.imagePadding = 4
            config.baseBackgroundColor = .clear
            config.baseForegroundColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)
            config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            e.clipsToBounds = true
            e.configuration = config
            e.layer.borderWidth = 1
            e.layer.borderColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1).cgColor
            e.layer.cornerRadius = 8
        }
    }
    
    private func configureImageView() {
        speechBubbleImageView.image = .bubble
        tamagotchiImageView.image = ._2_1
    }
    
    private func configureTextField() {
        textFieldArray.enumerated().forEach { (i, e) in
            e.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            e.borderStyle = .none
            e.placeholder = textFieldPlaceholderArray[i]
            e.textAlignment = .center
        }
    }
    
    private func configureNavigation() {
        navigationItem.title = "대장님의 다마고치"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)]
        
        let backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)
        navigationItem.backBarButtonItem = backBarButtonItem
        
        profileBarButtonItem.image = UIImage(systemName: "person.circle")
        profileBarButtonItem.tintColor = UIColor(red: 83/255, green: 105/255, blue: 118/255, alpha: 1)
    }
}
