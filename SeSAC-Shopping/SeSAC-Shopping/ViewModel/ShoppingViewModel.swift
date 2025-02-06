//
//  ShoppingViewModel.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 2/6/25.
//

import Foundation

final class ShoppingViewModel {
    
    // MARK: - properties
    let inputSearchButtonClicked: Observable<String?> = Observable(nil)
    
    let outputPushViewController: Observable<String> = Observable("")
    let outputShowAlert: Observable<Void?> = Observable(nil)
    
    // MARK: - life cycles
    init() {
        inputSearchButtonClicked.bind { [weak self] text in
            self?.clickedSearchButton(text: text)
        }
    }
    
    // MARK: - methods
    private func clickedSearchButton(text: String?) {
        if let query = text, query.count > 1 {
            outputPushViewController.value = query
        } else {
            outputShowAlert.value = ()
        }
    }
}
