//
//  TravelTableViewCell.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/3/25.
//

import UIKit
import Kingfisher

final class TravelTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet weak var travelImageView: UIImageView!
    @IBOutlet weak var travelTitleLabel: UILabel!
    @IBOutlet weak var travelContentLabel: UILabel!
    @IBOutlet weak var travelDateLabel: UILabel!
    
    static let identifier = "TravelTableViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        travelImageView.image = .init(systemName: "photo")
        travelTitleLabel.text = nil
        travelContentLabel.text = nil
        travelDateLabel.text = nil
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
        travelTitleLabel.font = .systemFont(ofSize: 23, weight: .bold)
        travelTitleLabel.numberOfLines = 2
        
        travelContentLabel.font = .systemFont(ofSize: 14, weight: .bold)
        travelContentLabel.textColor = .lightGray
        
        travelDateLabel.font = .systemFont(ofSize: 13, weight: .semibold)
        travelDateLabel.textColor = .lightGray
        travelDateLabel.textAlignment = .right
    }
    
    private func configureImageView() {
        travelImageView.contentMode = .scaleAspectFill
        travelImageView.clipsToBounds = true
        travelImageView.layer.cornerRadius = 12
    }
    
    func configureData(magazine: Magazine) {
        travelImageView.kf.setImage(with: URL(string: magazine.photo_image))
        travelTitleLabel.text = magazine.title
        travelContentLabel.text = magazine.subtitle
        travelDateLabel.text = magazine.date.format()
    }
}
