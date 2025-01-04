//
//  CityDetailInformationTableViewController.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/4/25.
//

import UIKit
import Kingfisher

final class CityDetailInformationTableViewController: UITableViewController {
    
    // MARK: - properties
    private let identifier = "CityDetailInformationTableViewCell"
    private var travelArray = TravelInfo().travel
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CityDetailInformationTableViewCell else { return UITableViewCell() }
        
        let travel = travelArray[indexPath.row]
        cell.cityTitleLabel.text = travel.title
        cell.cityDescriptionLabel.text = travel.description
        cell.citySaveLabel.text = "저장 \((travel.save ?? 0).format())"
        cell.cityLikeButton.setImage(.init(systemName: (travel.like ?? false) ? "heart.fill" : "heart"), for: .normal)
        cell.cityImageView.kf.setImage(with: URL(string: travel.travel_image ?? ""))
        
        return cell
    }
}
