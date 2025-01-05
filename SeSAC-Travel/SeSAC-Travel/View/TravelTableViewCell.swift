//
//  TravelTableViewCell.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/3/25.
//

import UIKit

final class TravelTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet weak var travelImageView: UIImageView!
    @IBOutlet weak var travelTitleLabel: UILabel!
    @IBOutlet weak var travelContentLabel: UILabel!
    @IBOutlet weak var travelDateLabel: UILabel!
    
    // MARK: - life cycles
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
}
