//
//  ChattingSenderTableViewCell.swift
//  SeSAC-TravelTalk
//
//  Created by 김정호 on 1/11/25.
//

import UIKit

final class ChattingSenderTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet private weak var senderBasedView: UIView!
    @IBOutlet private weak var senderChattingLabel: UILabel!
    @IBOutlet private weak var senderTimeLabel: UILabel!
    
    static let identifier = "ChattingSenderTableViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        senderChattingLabel.text = nil
        senderTimeLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        senderBasedView.clipsToBounds = true
        senderBasedView.layer.cornerRadius = 12
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureLabel()
    }
    
    private func configureView() {
        senderBasedView.backgroundColor = .systemGray5
        senderBasedView.layer.borderWidth = 1
        senderBasedView.layer.borderColor = UIColor.systemGray2.cgColor
    }
    
    private func configureLabel() {
        senderChattingLabel.font = .systemFont(ofSize: 12, weight: .medium)
        senderChattingLabel.numberOfLines = 0
        
        senderTimeLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        senderTimeLabel.textColor = .systemGray
    }
    
    func configureData(chat: Chat?) {
        guard let chat else { return }
        senderChattingLabel.text = chat.message
        senderTimeLabel.text = chat.date.formatTime()
    }
}
