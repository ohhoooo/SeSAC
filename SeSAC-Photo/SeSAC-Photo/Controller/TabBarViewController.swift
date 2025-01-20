//
//  TabBarViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarController()
        configureTabBarAppearence()
    }
    
    // MARK: - methods
    private func configureTabBarController() {
        let photoTopicVC = NavigationBarViewController(rootViewController: PhotoTopicViewController())
        photoTopicVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 0)
        
        let photoSearchVC = NavigationBarViewController(rootViewController: PhotoSearchViewController())
        photoSearchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        setViewControllers([photoTopicVC, photoSearchVC], animated: true)
    }
    
    private func configureTabBarAppearence() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = .white
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.selected.iconColor = .black
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}
