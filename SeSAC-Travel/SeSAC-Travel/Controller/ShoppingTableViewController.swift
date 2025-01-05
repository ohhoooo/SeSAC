//
//  ShoppingTableViewController.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/4/25.
//

import UIKit

final class ShoppingTableViewController: UITableViewController {
    
    // MARK: - properties
    @IBOutlet weak var shoppingBasedView: UIView!
    @IBOutlet weak var shoppingTextField: UITextField!
    @IBOutlet weak var additionButton: UIButton!
    
    private let identifier = "ShoppingTableViewCell"
    private var purchaseList: [Shopping] = [Shopping(title: "그립톡 구매하기", purchase: true, bookmark: true),
                                        Shopping(title: "사이다 구매", purchase: false, bookmark: false),
                                        Shopping(title: "아이패드 케이스 최저가 알아보기", purchase: false, bookmark: true),
                                        Shopping(title: "양말", purchase: false, bookmark: true)]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureButton()
        configureTextField()
    }
    
    private func configureView() {
        shoppingBasedView.clipsToBounds = true
        shoppingBasedView.backgroundColor = .systemGray6
        shoppingBasedView.layer.cornerRadius = 8
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.title = "추가"
        config.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        config.baseBackgroundColor = .systemGray5
        config.baseForegroundColor = .black
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        additionButton.configuration = config
        additionButton.clipsToBounds = true
        additionButton.layer.cornerRadius = 8
    }
    
    private func configureTextField() {
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.borderStyle = .none
        shoppingTextField.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        guard let text = shoppingTextField.text, text.count > 0 else { return }
        purchaseList.append(Shopping(title: text, purchase: false, bookmark: false))
        tableView.insertRows(at: [IndexPath(row: purchaseList.count - 1, section: 0)], with: .automatic)
    }
    
    @objc
    private func tappedPurchaseAndBookmarkButton(_ sender: UIButton) {
        if sender.tag % 2 == 0 {
            purchaseList[sender.tag / 2].purchase.toggle()
        } else {
            purchaseList[sender.tag / 2].bookmark.toggle()
        }
        
        tableView.reloadRows(at: [IndexPath(row: sender.tag / 2, section: 0)], with: .automatic)
    }
}

// MARK: - extensions
extension ShoppingTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchaseList.count
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (_, _, success: @escaping (Bool) -> Void) in
            self.purchaseList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? ShoppingTableViewCell else { return UITableViewCell() }
        
        let purchase = purchaseList[indexPath.row]
        let purchaseImage = UIImage(systemName: purchase.purchase ? "checkmark.square.fill" : "checkmark.square")?.resize(width: 22, height: 20)
        let bookmarkImage = UIImage(systemName: purchase.bookmark ? "star.fill" : "star")?.resize(width: 22, height: 20)
        cell.selectionStyle = .none
        cell.titleLabel.text = purchase.title
        cell.purchaseButton.tag = indexPath.row * 2
        cell.bookmarkButton.tag = indexPath.row * 2 + 1
        cell.purchaseButton.setImage(purchaseImage, for: .normal)
        cell.bookmarkButton.setImage(bookmarkImage, for: .normal)
        cell.purchaseButton.addTarget(self, action: #selector(tappedPurchaseAndBookmarkButton), for: .touchUpInside)
        cell.bookmarkButton.addTarget(self, action: #selector(tappedPurchaseAndBookmarkButton), for: .touchUpInside)
        
        return cell
    }
}
