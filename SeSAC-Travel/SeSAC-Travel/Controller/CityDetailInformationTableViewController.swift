//
//  CityDetailInformationTableViewController.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/4/25.
//

import UIKit

final class CityDetailInformationTableViewController: UITableViewController {
    
    // MARK: - properties
    private var travelArray = TravelInfo().travel
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
    }
    
    // MARK: - methods
    private func configureData() {
        travelArray.enumerated().forEach { (i, e) in
            if e.like == nil {
                travelArray[i].like = false
            }
        }
    }
    
    @objc
    private func tappedCityLikeButton(_ sender: UIButton) {
        travelArray[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
}

// MARK: - extensions
extension CityDetailInformationTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityDetailInformationTableViewCell.identifier, for: indexPath) as? CityDetailInformationTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configureData(travel: travelArray[indexPath.row])
        cell.cityLikeButton.tag = indexPath.row
        cell.cityLikeButton.addTarget(self, action: #selector(tappedCityLikeButton), for: .touchUpInside)
        
        return cell
    }
}
