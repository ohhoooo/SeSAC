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
        configureView()
        configureSearchBar()
        configureNavigation()
    }
    
    private func configureView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedTapGesture)))
    }
    
    private func configureSearchBar() {
        shoppingView.searchBar.delegate = self
    }
    
    private func configureNavigation() {
        navigationItem.title = "정호의 쇼핑쇼핑"
    }
    
    @objc
    private func tappedTapGesture() {
        view.endEditing(true)
    }
}

extension ShoppingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, keyword.count > 1 else { return }
        let resultVC = ResultViewController()
        resultVC.keyword = keyword
        navigationController?.pushViewController(resultVC, animated: true)
    }
}
