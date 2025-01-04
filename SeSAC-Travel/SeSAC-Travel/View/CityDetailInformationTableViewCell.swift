//
//  CityDetailInformationTableViewCell.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/4/25.
//

import UIKit

final class CityDetailInformationTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    @IBOutlet weak var citySaveLabel: UILabel!
    @IBOutlet weak var cityLikeButton: UIButton!
    @IBOutlet weak var cityImageView: UIImageView!
    
    // MARK: - methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    private func configureUI() {
        configureLabel()
        configureButton()
        configureImageView()
    }
    
    private func configureLabel() {
        cityTitleLabel.font = .boldSystemFont(ofSize: 18)
        cityTitleLabel.numberOfLines = 2
        
        cityDescriptionLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        cityDescriptionLabel.textColor = .systemGray
        cityDescriptionLabel.numberOfLines = 2
        
        citySaveLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        citySaveLabel.textColor = .systemGray2
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.contentInsets = .init(top: 8, leading: 4, bottom: 8, trailing: 4)
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .systemRed
        cityLikeButton.configuration = config
    }
    
    private func configureImageView() {
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 8
    }
}
