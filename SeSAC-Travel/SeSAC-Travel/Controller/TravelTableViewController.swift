//
//  ViewController.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/3/25.
//

import UIKit
import Kingfisher

final class TravelTableViewController: UITableViewController {
    
    // MARK: - properties
    private let magazineArray = MagazineInfo().magazine
    private let identifier = "TravelTableViewCell"
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    // MARK: - methods
    private func configureTableView() {
        tableView.separatorStyle = .none
    }
}

// MARK: - extensions
extension TravelTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazineArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TravelTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.travelImageView.kf.setImage(with: URL(string: magazineArray[indexPath.row].photo_image))
        cell.travelTitleLabel.text = magazineArray[indexPath.row].title
        cell.travelContentLabel.text = magazineArray[indexPath.row].subtitle
        cell.travelDateLabel.text = magazineArray[indexPath.row].date.format()
        
        return cell
    }
}
