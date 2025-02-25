//
//  ShoppingViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit
import RxSwift
import RxCocoa

final class ShoppingViewController: BaseViewController {
    
    // MARK: - properties
    private let shoppingView = ShoppingView()
    private let viewModel = ShoppingViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func loadView() {
        view = shoppingView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedTapGesture)))
    }
    
    override func bind() {
        let input = ShoppingViewModel.Input(
            text: shoppingView.searchBar.rx.text,
            searchButtonClicked: shoppingView.searchBar.rx.searchButtonClicked
        )
        
        let output = viewModel.transform(input: input)
        
        output.alert
            .bind(with: self) { owner, _ in
                owner.showAlert(title: "알림", message: "두 글자 이상 입력하세요.", button: "확인")
            }
            .disposed(by: disposeBag)
        
        output.query
            .bind(with: self) { owner, value in
                let resultVM = ResultViewModel(query: value)
                let resultVC = ResultViewController(viewModel: resultVM)
                owner.navigationController?.pushViewController(resultVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation() {
        navigationItem.title = "정호의 쇼핑쇼핑"
    }
    
    @objc
    private func tappedTapGesture() {
        view.endEditing(true)
    }
}
