//
//  UpDownGameCollectionViewCell.swift
//  SeSAC-UpDownGame
//
//  Created by 김정호 on 1/9/25.
//

import UIKit

final class UpDownGameCollectionViewCell: UICollectionViewCell {
    
    // MARK: - properties
    @IBOutlet private weak var numberLabel: UILabel!
    
    static let identifier = "UpDownGameCollectionViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        numberLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        numberLabel.clipsToBounds = true
        numberLabel.layer.cornerRadius = frame.width / 2
    }
    
    // MARK: - methods
    private func configureUI() {
        configureLabel()
    }
    
    private func configureLabel() {
        numberLabel.textAlignment = .center
        numberLabel.backgroundColor = .white
    }
    
    func configureData(text: String) {
        numberLabel.text = text
    }
}
