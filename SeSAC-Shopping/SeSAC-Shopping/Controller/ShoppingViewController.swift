//
//  ShoppingViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit

final class ShoppingViewController: UIViewController {
    
    // MARK: - properties
    private let shoppingView = ShoppingView()
    
    // MARK: - life cycles
    override func loadView() {
        view = shoppingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - extensions
extension ShoppingViewController {
    private func configureUI() {
        configureNavigation()
    }
    
    private func configureNavigation() {
        navigationItem.title = "정호의 쇼핑쇼핑"
    }
}
