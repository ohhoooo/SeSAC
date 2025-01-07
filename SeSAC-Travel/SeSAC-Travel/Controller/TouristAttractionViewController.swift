//
//  TouristAttractionViewController.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/7/25.
//

import UIKit
import Kingfisher

final class TouristAttractionViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var touristAttractionImageView: UIImageView!
    @IBOutlet weak var touristAttractionTitleLabel: UILabel!
    @IBOutlet weak var touristAttractionDescriptionLabel: UILabel!
    @IBOutlet weak var touristAttractionPopButton: UIButton!
    
    var travel: Travel?
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureData()
        configureNavigation()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureLabel()
        configureButton()
        configureImageView()
    }
    
    private func configureLabel() {
        touristAttractionTitleLabel.font = .boldSystemFont(ofSize: 32)
        touristAttractionTitleLabel.numberOfLines = 0
        touristAttractionTitleLabel.textAlignment = .center
        
        touristAttractionDescriptionLabel.font = .boldSystemFont(ofSize: 22)
        touristAttractionDescriptionLabel.numberOfLines = 0
        touristAttractionDescriptionLabel.textAlignment = .center
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.title = "다른 관광지 보러 가기"
        config.contentInsets = .init(top: 12, leading: 16, bottom: 12, trailing: 16)
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor(red: 127/255, green: 175/255, blue: 229/255, alpha: 1)
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        touristAttractionPopButton.configuration = config
        touristAttractionPopButton.clipsToBounds = true
        touristAttractionPopButton.layer.cornerRadius = 20
    }
    
    private func configureImageView() {
        touristAttractionImageView.image = UIImage(systemName: "photo")
        touristAttractionImageView.contentMode = .scaleAspectFill
        touristAttractionImageView.clipsToBounds = true
        touristAttractionImageView.layer.cornerRadius = 12
    }
    
    private func configureData() {
        if let url = travel?.travel_image {
            touristAttractionImageView.kf.setImage(with: URL(string: url))
        } else {
            touristAttractionImageView.image = UIImage(systemName: "photo")
            touristAttractionImageView.contentMode = .scaleToFill
        }
        
        touristAttractionTitleLabel.text = travel?.title
        touristAttractionDescriptionLabel.text = travel?.description
    }
    
    private func configureNavigation() {
        navigationItem.title = "관광지 화면"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
}
