//
//  RestaurantViewController.swift
//  SeSAC-RestaurantAnd369Game
//
//  Created by 김정호 on 1/8/25.
//

import UIKit
import MapKit

final class RestaurantViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet private weak var filterBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var restaurantMapView: MKMapView!
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureNavigation()
        configureMapView()
    }
    
    private func configureNavigation() {
        navigationItem.title = "식당"
        
        filterBarButtonItem.title = "Filter"
        filterBarButtonItem.target = self
        filterBarButtonItem.action = #selector(tappedFilterBarButtonItem)
        filterBarButtonItem.tintColor = .systemGray
    }
    
    @objc
    private func tappedFilterBarButtonItem(_ sender: UIBarButtonItem) {
        print(#function)
    }
    
    private func configureMapView() {
        
    }
}
