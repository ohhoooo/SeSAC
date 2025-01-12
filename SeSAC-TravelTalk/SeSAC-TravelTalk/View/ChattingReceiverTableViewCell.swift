//
//  ChattingReceiverTableViewCell.swift
//  SeSAC-TravelTalk
//
//  Created by 김정호 on 1/11/25.
//

import UIKit

final class ChattingReceiverTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet private weak var receiverImageView: UIImageView!
    @IBOutlet private weak var receiverNameLabel: UILabel!
    @IBOutlet private weak var receiverBasedView: UIView!
    @IBOutlet private weak var receiverChattingLabel: UILabel!
    @IBOutlet private weak var receiverTimeLabel: UILabel!
    
    static let identifier = "ChattingReceiverTableViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        receiverImageView.image = nil
        receiverNameLabel.text = nil
        receiverChattingLabel.text = nil
        receiverTimeLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        receiverImageView.clipsToBounds = true
        receiverImageView.layer.cornerRadius = receiverImageView.frame.width / 2
        
        receiverBasedView.clipsToBounds = true
        receiverBasedView.layer.cornerRadius = 12
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
        receiverBasedView.layer.borderWidth = 1
        receiverBasedView.layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    private func configureLabel() {
        receiverNameLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        receiverChattingLabel.font = .systemFont(ofSize: 12, weight: .medium)
        receiverChattingLabel.numberOfLines = 0
        
        receiverTimeLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        receiverTimeLabel.textColor = .systemGray
    }
    
    private func configureImageView() {
        receiverImageView.contentMode = .scaleAspectFill
    }
    
    func configureData(chat: Chat?) {
        guard let chat else { return }
        receiverNameLabel.text = chat.user.rawValue
        receiverChattingLabel.text = chat.message
        receiverTimeLabel.text = chat.date.formatTime()
        receiverImageView.image = UIImage(named: "\(chat.user.profileImage)")
    }
}
