//
//  CityDetailInformationAdvertisementTableViewCell.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/7/25.
//

import UIKit

final class CityDetailInformationAdvertisementTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet weak var adBasedView: UIView!
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var adButton: UIButton!
    
    static let identifier = "CityDetailInformationAdvertisementTableViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        adTitleLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureLabel()
        configureButton()
    }
    
    private func configureView() {
        adBasedView.clipsToBounds = true
        adBasedView.layer.cornerRadius = 8
    }
    
    private func configureLabel() {
        adTitleLabel.font = .systemFont(ofSize: 14, weight: .heavy)
        adTitleLabel.numberOfLines = 2
        adTitleLabel.textAlignment = .center
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.title = "AD"
        config.contentInsets = .init(top: 4, leading: 8, bottom: 4, trailing: 8)
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 12)
        adButton.configuration = config
        adButton.clipsToBounds = true
        adButton.layer.cornerRadius = 8
    }
    
    func configureData(title: String, isEven: Bool) {
        adTitleLabel.text = title
        adBasedView.backgroundColor = isEven ? UIColor(red: 255/255, green: 211/255, blue: 211/255, alpha: 1) : UIColor(red: 213/255, green: 255/255, blue: 210/255, alpha: 1)
    }
}
