//
//  PopularityCityViewController.swift
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
        cityCollectionView.register(PopularityCityCollectionViewCell.self, forCellWithReuseIdentifier: PopularityCityCollectionViewCell.identifier)
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
    }
}

// MARK: - extensions
extension CityCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularityCityCollectionViewCell.identifier, for: indexPath) as? PopularityCityCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(travel: cityArray[indexPath.row])
        
        return cell
    }
}
