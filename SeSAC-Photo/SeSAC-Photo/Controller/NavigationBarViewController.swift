//
//  NavigationBarViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import UIKit

final class NavigationBarViewController: UINavigationController {
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBarAppearence()
    }
    
    // MARK: - methods
    private func configureNavigationBarAppearence() {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = .white
        appearence.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearence
        UINavigationBar.appearance().scrollEdgeAppearance = appearence
    }
}
