//
//  BirthdayViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit

final class BirthdayViewController: BaseViewController {
    
    // MARK: - properties
    private let birthdayView = BirthdayView()
    
    // MARK: - life cycles
    override func loadView() {
        view = birthdayView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureAddTarget() {
        birthdayView.okBarButtonItem.target = self
        birthdayView.okBarButtonItem.action = #selector(tappedOkBarButtonItem)
    }
    
    private func configureNavigation() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = birthdayView.okBarButtonItem
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc
    private func tappedOkBarButtonItem() {
        print(#function)
    }
}
