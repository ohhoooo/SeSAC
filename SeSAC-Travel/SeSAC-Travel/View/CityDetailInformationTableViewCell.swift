//
//  CityDetailInformationTableViewCell.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/4/25.
//

import UIKit
import Kingfisher

final class CityDetailInformationTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet weak var cityTitleLabel: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    @IBOutlet weak var citySaveLabel: UILabel!
    @IBOutlet weak var cityLikeButton: UIButton!
    @IBOutlet weak var cityImageView: UIImageView!
    
    static let identifier = "CityDetailInformationTableViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        cityTitleLabel.text = nil
        cityDescriptionLabel.text = nil
        citySaveLabel.text = nil
        cityImageView.image = .init(systemName: "photo")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: - methods
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
        cityImageView.image = .init(systemName: "photo")
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 8
    }
    
    func configureData(travel: Travel) {
        cityTitleLabel.text = travel.title
        cityDescriptionLabel.text = travel.description
        citySaveLabel.text = "저장 \((travel.save ?? 0).format())"
        cityLikeButton.setImage(.init(systemName: (travel.like ?? false) ? "heart.fill" : "heart"), for: .normal)
        guard let url = travel.travel_image else { return }
        cityImageView.kf.setImage(with: URL(string: url))
    }
}
