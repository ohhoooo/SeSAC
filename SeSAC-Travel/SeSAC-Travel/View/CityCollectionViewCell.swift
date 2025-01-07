//
//  CityCollectionViewCell.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/8/25.
//

import UIKit
import Kingfisher

final class CityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - properties
    @IBOutlet private weak var cityImageView: UIImageView!
    @IBOutlet private weak var cityNameLabel: UILabel!
    @IBOutlet private weak var cityExplainLabel: UILabel!
    
    static let identifier = "CityCollectionViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cityImageView.image = .init(systemName: "photo")
        cityNameLabel.text = nil
        cityExplainLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureLabel()
        configureImageView()
    }
    
    private func configureLabel() {
        cityNameLabel.font = .systemFont(ofSize: 13, weight: .heavy)
        cityNameLabel.textAlignment = .center
        
        cityExplainLabel.font = .systemFont(ofSize: 12, weight: .heavy)
        cityExplainLabel.textColor = .systemGray
        cityExplainLabel.numberOfLines = 0
        cityExplainLabel.textAlignment = .center
    }
    
    private func configureImageView() {
        cityImageView.image = .init(systemName: "photo")
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        cityImageView.layer.cornerRadius = 82
    }
    
    func configureData(city: City) {
        cityNameLabel.text = "\(city.city_name) | \(city.city_english_name)"
        cityExplainLabel.text = city.city_explain
        cityImageView.kf.setImage(with: URL(string: city.city_image))
    }
}
