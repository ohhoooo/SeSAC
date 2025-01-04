//
//  ShoppingTableViewCell.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/4/25.
//

import UIKit

final class ShoppingTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet weak var basedView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    // MARK: - methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    private func configureUI() {
        configureView()
        configureLabel()
        configureButton()
    }
    
    private func configureView() {
        basedView.clipsToBounds = true
        basedView.backgroundColor = .systemGray6
        basedView.layer.cornerRadius = 8
    }
    
    private func configureLabel() {
        titleLabel.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        purchaseButton.configuration = config
        bookmarkButton.configuration = config
    }
}
