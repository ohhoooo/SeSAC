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
        numberLabel.textColor = .black
        numberLabel.backgroundColor = .white
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
    
    func configureData(text: String, isSelected: Bool) {
        numberLabel.text = text
        numberLabel.textColor = isSelected ? .white : .black
        numberLabel.backgroundColor = isSelected ? .black : .white
    }
    
    func fetchNumber() -> Int {
        guard let text = numberLabel.text, let number = Int(text) else { return 0 }
        return number
    }
}
