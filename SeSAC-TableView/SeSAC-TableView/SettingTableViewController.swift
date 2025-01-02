//
//  SettingTableViewController.swift
//  SeSAC-TableView
//
//  Created by 김정호 on 1/3/25.
//

import UIKit

final class SettingTableViewController: UITableViewController {
    
    // MARK: - properties
    private let identifier = "setting"
    private let headerTextArray = ["전체 설정", "개인 설정", "기타"]
    private let rowTextArray = [["공지사항", "실험실", "버전 정보"], ["개인/보안", "알림", "채팅", "멀티프로필"], ["고객센터/도움말"]]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 44
    }
}

// MARK: - extensions
extension SettingTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return headerTextArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return rowTextArray[0].count
        case 1:
            return rowTextArray[1].count
        default:
            return rowTextArray[2].count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTextArray[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = rowTextArray[indexPath.section][indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        cell.textLabel?.textColor = .black
        
        return cell
    }
}
