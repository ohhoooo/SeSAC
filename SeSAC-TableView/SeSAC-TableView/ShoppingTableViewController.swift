//
//  ShoppingTableViewController.swift
//  SeSAC-TableView
//
//  Created by 김정호 on 1/3/25.
//

import UIKit

final class ShoppingTableViewController: UITableViewController {
    
    // MARK: - properties
    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var headerButton: UIButton!
    
    private let identifier = "shopping"
    private var shoppingArray: [String] = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureButton()
        configureTextField()
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.title = "추가"
        config.attributedTitle?.font = .systemFont(ofSize: 16, weight: .regular)
        config.baseBackgroundColor = UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1)
        config.baseForegroundColor = .black
        headerButton.configuration = config
        headerButton.clipsToBounds = true
        headerButton.layer.cornerRadius = 8
    }
    
    private func configureTextField() {
        headerTextField.placeholder = "무엇을 구매하실 건가요?"
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        guard let text = headerTextField.text, text.count > 0 else { return }
        shoppingArray.append(text)
        tableView.insertRows(at: [IndexPath(row: shoppingArray.count - 1, section: 0)], with: .automatic)
    }
}

// MARK: - extensions
extension ShoppingTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = shoppingArray[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        cell.textLabel?.textColor = .black
        cell.imageView?.tintColor = .black
        
        return cell
    }
}
