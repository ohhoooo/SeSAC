//
//  ShoppingViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit

final class ShoppingViewController: BaseViewController {
    
    // MARK: - properties
    private let shoppingView = ShoppingView()
    private let viewModel = ShoppingViewModel()
    
    // MARK: - life cycles
    override func loadView() {
        view = shoppingView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    // MARK: - methods
    override func configureDelegate() {
        shoppingView.searchBar.delegate = self
    }
    
    override func configureAddTarget() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedTapGesture)))
    }
    
    override func bind() {
        viewModel.outputPushViewController.lazyBind { [weak self] query in
            let resultVC = ResultViewController()
            resultVC.viewModel.inputQuery.value = query
            self?.navigationController?.pushViewController(resultVC, animated: true)
        }
        
        viewModel.outputShowAlert.lazyBind { [weak self] _ in
            self?.showAlert(title: "알림", message: "두 글자 이상 입력하세요.", button: "확인")
        }
    }
    
    private func configureNavigation() {
        navigationItem.title = "정호의 쇼핑쇼핑"
    }
    
    @objc
    private func tappedTapGesture() {
        view.endEditing(true)
    }
}

// MARK: - extensions
extension ShoppingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchButtonClicked.value = searchBar.text
    }
}
