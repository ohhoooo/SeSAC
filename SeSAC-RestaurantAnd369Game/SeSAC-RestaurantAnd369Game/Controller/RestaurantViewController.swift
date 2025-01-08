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
    
    private let restaurantArray = RestaurantList().restaurantArray
    private var restaurantFilteredArray = RestaurantList().restaurantArray
    
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
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let menuType = ["한식", "중식", "일식", "양식", "분식", "샐러드", "카페"]
        
        for menu in menuType {
            let alertAction = UIAlertAction(title: menu, style: .default) { [weak self] alertAction in
                guard let self else { return }
                restaurantFilteredArray = restaurantArray.filter { $0.category == alertAction.title }
                configureMapView()
            }
            
            alertController.addAction(alertAction)
        }
        
        let totalAlertAction = UIAlertAction(title: "전체보기", style: .default) { [weak self] _ in
            guard let self else { return }
            restaurantFilteredArray = restaurantArray
            configureMapView()
        }
        
        let cancelAlertAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(totalAlertAction)
        alertController.addAction(cancelAlertAction)
        
        present(alertController, animated: true)
    }
    
    private func configureMapView() {
        restaurantMapView.removeAnnotations(restaurantMapView.annotations)
        
        for restaurant in restaurantFilteredArray {
            let coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            let annotation = MKPointAnnotation()
            annotation.title = restaurant.name
            annotation.coordinate = coordinate
            
            restaurantMapView.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            restaurantMapView.addAnnotation(annotation)
        }
    }
}
