//
//  CityTableViewCell.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/6/25.
//

import UIKit
import Kingfisher

final class CityTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet private weak var cityImageView: UIImageView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityExplainBasedView: UIView!
    @IBOutlet private weak var cityExplainLabel: UILabel!
    
    static let identifier = "CityTableViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cityNameLabel.text = nil
        cityNameLabel.text = nil
        cityImageView.image = .init(systemName: "photo")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureLabel()
        configureImageView()
    }
    
    private func configureView() {
        cityExplainBasedView.clipsToBounds = true
        cityExplainBasedView.backgroundColor = .black.withAlphaComponent(0.5)
        cityExplainBasedView.layer.cornerRadius = 20
        cityExplainBasedView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMaxXMaxYCorner])
    }
    
    private func configureLabel() {
        cityNameLabel.font = .boldSystemFont(ofSize: 20)
        cityNameLabel.textColor = .white
        
        cityExplainLabel.font = .systemFont(ofSize: 14, weight: .regular)
        cityExplainLabel.textColor = .white
    }
    
    private func configureImageView() {
        cityImageView.image = .init(systemName: "photo")
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 20
        cityImageView.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMaxYCorner])
    }
    
    func configureData(city: City) {
        cityNameLabel.text = "\(city.city_name) | \(city.city_english_name)"
        cityExplainLabel.text = city.city_explain
        cityImageView.kf.setImage(with: URL(string: city.city_image))
    }
}
