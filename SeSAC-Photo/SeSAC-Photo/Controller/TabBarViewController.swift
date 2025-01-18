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
        let photoSearchVC = NavigationBarViewController(rootViewController: PhotoSearchViewController())
        photoSearchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        setViewControllers([photoSearchVC], animated: true)
    }
    
    private func configureTabBarAppearence() {
        let appearence = UITabBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.backgroundColor = .white
        appearence.stackedLayoutAppearance.normal.iconColor = .gray
        appearence.stackedLayoutAppearance.selected.iconColor = .black
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
    }
}
