//
//  TravelTalkTableViewCell.swift
//  SeSAC-TravelTalk
//
//  Created by 김정호 on 1/10/25.
//

import UIKit

final class TravelTalkTableViewCell: UITableViewCell {
    
    // MARK: - properties
    @IBOutlet private weak var chatRoomImageView: UIImageView!
    @IBOutlet private weak var chatRoomUserLabel: UILabel!
    @IBOutlet private weak var chatRoomMessageLabel: UILabel!
    @IBOutlet private weak var chatRoomDateLabel: UILabel!
    
    static let identifier = "TravelTalkTableViewCell"
    
    // MARK: - life cycles
    override func prepareForReuse() {
        super.prepareForReuse()
        
        chatRoomImageView.image = nil
        chatRoomUserLabel.text = nil
        chatRoomMessageLabel.text = nil
        chatRoomDateLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        chatRoomImageView.clipsToBounds = true
        chatRoomImageView.layer.cornerRadius = chatRoomImageView.frame.width / 2
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
        chatRoomUserLabel.font = .boldSystemFont(ofSize: 14)
        
        chatRoomMessageLabel.font = .systemFont(ofSize: 12, weight: .medium)
        chatRoomMessageLabel.textColor = .systemGray
        
        chatRoomDateLabel.font = .systemFont(ofSize: 11, weight: .medium)
        chatRoomDateLabel.textColor = .systemGray
    }
    
    private func configureImageView() {
        chatRoomImageView.contentMode = .scaleAspectFill
    }
    
    func configureData(chatRoom: ChatRoom) {
        chatRoomUserLabel.text = chatRoom.chatRoomName
        chatRoomMessageLabel.text = (chatRoom.chatList.count > 0) ? chatRoom.chatList[chatRoom.chatList.count - 1].message : ""
        chatRoomDateLabel.text = (chatRoom.chatList.count > 0) ? chatRoom.chatList[chatRoom.chatList.count - 1].date.format() : ""
        
        if let imageName = chatRoom.chatRoomImage.first {
            chatRoomImageView.image = UIImage(named: imageName)
        } else {
            chatRoomImageView.image = UIImage(systemName: "photo")
        }
    }
}
