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
    
    static let identifier = "ShoppingTableViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        titleLabel.text = nil
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
    
    func configureData(shopping: Shopping) {
        let purchaseImage = UIImage(systemName: shopping.purchase ? "checkmark.square.fill" : "checkmark.square")?.resize(width: 22, height: 20)
        let bookmarkImage = UIImage(systemName: shopping.bookmark ? "star.fill" : "star")?.resize(width: 22, height: 20)
        titleLabel.text = shopping.title
        purchaseButton.setImage(purchaseImage, for: .normal)
        bookmarkButton.setImage(bookmarkImage, for: .normal)
    }
}
