//
//  CityTableViewController.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/6/25.
//

import UIKit

final class CityTableViewController: UITableViewController {
    
    // MARK: - properties
    @IBOutlet private weak var cityTextField: UITextField!
    @IBOutlet private weak var citySegmentedControl: UISegmentedControl!
    
    private var cityArray = CityInfo().city
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureTableView()
        configureTextField()
        configureSegmentedControl()
    }
    
    private func configureTableView() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "CityTableViewCell", bundle: nil), forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    private func configureTextField() {
        cityTextField.placeholder = "검색할 도시를 입력하세요."
    }
    
    private func configureSegmentedControl() {
        citySegmentedControl.setTitle("모두", forSegmentAt: 0)
        citySegmentedControl.setTitle("국내", forSegmentAt: 1)
        citySegmentedControl.insertSegment(withTitle: "해외", at: 2, animated: true)
    }
    
    @IBAction func didEndOnExitTextField(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else { return }
        searchCitys(text: text)
    }
    
    @IBAction func editingChangedTextField(_ sender: UITextField) {
        guard let text = sender.text, !text.isEmpty else { return }
        searchCitys(text: text)
    }
    
    private func searchCitys(text: String) {
        switch citySegmentedControl.selectedSegmentIndex {
        case 0:
            cityArray = CityInfo().city
        case 1:
            cityArray = CityInfo().city.filter { $0.domestic_travel }
        default:
            cityArray = CityInfo().city.filter { !$0.domestic_travel }
        }
        
        cityArray = cityArray.filter { $0.city_name.uppercased().contains(text.uppercased()) || $0.city_english_name.uppercased().contains(text.uppercased()) || $0.city_explain.uppercased().contains(text.uppercased()) }
        tableView.reloadData()
    }
    
    @IBAction private func tappedSegmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            cityArray = CityInfo().city
        case 1:
            cityArray = CityInfo().city.filter { $0.domestic_travel }
        default:
            cityArray = CityInfo().city.filter { !$0.domestic_travel }
        }
        
        tableView.reloadData()
    }
}

// MARK: - extensions
extension CityTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configureData(city: cityArray[indexPath.row])
        
        return cell
    }
}
