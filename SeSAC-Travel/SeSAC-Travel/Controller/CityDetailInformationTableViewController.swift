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
    private let adArray = ["하와이 여행을 가고싶다면?\n수업이 있는데 가실 생각은 아니시죠?", "도쿄 여행 예약은?\nXCode로 직접 예약앱을 만들면 되겠네요"]
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "도시 상세 정보"
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
        return travelArray[indexPath.row].ad ? 80 : 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if travelArray[indexPath.row].ad {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityDetailInformationAdvertisementTableViewCell.identifier, for: indexPath) as? CityDetailInformationAdvertisementTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            cell.configureData(title: adArray[indexPath.row % 2], isEven: (indexPath.row % 2 == 0))
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityDetailInformationTableViewCell.identifier, for: indexPath) as? CityDetailInformationTableViewCell else { return UITableViewCell() }
            
            if travelArray.count - 1 > indexPath.row && travelArray[indexPath.row + 1].ad {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            }
            
            cell.selectionStyle = .none
            cell.configureData(travel: travelArray[indexPath.row])
            cell.cityLikeButton.tag = indexPath.row
            cell.cityLikeButton.addTarget(self, action: #selector(tappedCityLikeButton), for: .touchUpInside)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let touristAttractionVC = storyboard?.instantiateViewController(withIdentifier: "TouristAttractionViewController") as? TouristAttractionViewController else { return }
        
        touristAttractionVC.travel = travelArray[indexPath.row]
        navigationController?.pushViewController(touristAttractionVC, animated: true)
    }
}
