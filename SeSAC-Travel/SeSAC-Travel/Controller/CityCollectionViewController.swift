//
//  CityCollectionViewController.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/8/25.
//

import UIKit

final class CityCollectionViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var citySegmentedControl: UISegmentedControl!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    private var cityArray = CityInfo().city
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureNavigation()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureSegmentedControl()
        configureCollectionView()
    }
    
    private func configureSegmentedControl() {
        citySegmentedControl.setTitle("모두", forSegmentAt: 0)
        citySegmentedControl.setTitle("국내", forSegmentAt: 1)
        citySegmentedControl.insertSegment(withTitle: "해외", at: 2, animated: true)
    }
    
    private func configureCollectionView() {
        cityCollectionView.register(UINib(nibName: "CityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 164, height: 244)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 16, bottom: 12, right: 16)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        cityCollectionView.collectionViewLayout = layout
    }
    
    private func configureNavigation() {
        navigationItem.title = "인기 도시"
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
        
        cityCollectionView.reloadData()
    }
}

// MARK: - extensions
extension CityCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(city: cityArray[indexPath.row])
        
        return cell
    }
}
