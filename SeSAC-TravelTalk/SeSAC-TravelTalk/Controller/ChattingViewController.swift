//
//  ChattingViewController.swift
//  SeSAC-TravelTalk
//
//  Created by 김정호 on 1/11/25.
//

import UIKit

final class ChattingViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet private weak var chattingTableView: UITableView!
    @IBOutlet private weak var chattingBasedView: UIView!
    @IBOutlet private weak var chattingInputTextView: UITextView!
    @IBOutlet private weak var chattingSendButton: UIButton!
    
    var chatRoom: ChatRoom?
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureButton()
        configureTextView()
        configureTableView()
        configureNavigation()
    }
    
    private func configureView() {
        chattingBasedView.clipsToBounds = true
        chattingBasedView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        chattingBasedView.layer.cornerRadius = 10
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.image = UIImage(systemName: "paperplane")
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .systemGray3
        chattingSendButton.configuration = config
    }
    
    private func configureTextView() {
        chattingInputTextView.text = "메세지를 입력하세요"
        chattingInputTextView.font = .systemFont(ofSize: 14, weight: .semibold)
        chattingInputTextView.delegate = self
        chattingInputTextView.textColor = .lightGray
        chattingInputTextView.borderStyle = .none
        chattingInputTextView.backgroundColor = .clear
    }
    
    private func configureTableView() {
        chattingTableView.delegate = self
        chattingTableView.dataSource = self
        chattingTableView.separatorStyle = .none
        chattingTableView.register(UINib(nibName: "ChattingSenderTableViewCell", bundle: nil), forCellReuseIdentifier: ChattingSenderTableViewCell.identifier)
        chattingTableView.register(UINib(nibName: "ChattingReceiverTableViewCell", bundle: nil), forCellReuseIdentifier: ChattingReceiverTableViewCell.identifier)
    }
    
    private func configureNavigation() {
        navigationItem.title = chatRoom?.chatRoomName
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
    }
}

// MARK: - extensions
extension ChattingViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "메세지를 입력하세요"
            textView.textColor = .lightGray
        }
    }
}

extension ChattingViewController: UITableViewDelegate {
    
}

extension ChattingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom?.chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chatRoom?.chatList[indexPath.row].user == .user {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingSenderTableViewCell.identifier, for: indexPath) as? ChattingSenderTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.configureData(chat: chatRoom?.chatList[indexPath.row])
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChattingReceiverTableViewCell.identifier, for: indexPath) as? ChattingReceiverTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.configureData(chat: chatRoom?.chatList[indexPath.row])
            
            return cell
        }
    }
}
