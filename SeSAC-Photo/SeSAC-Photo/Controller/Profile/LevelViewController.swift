//
//  LevelViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/23/25.
//

import UIKit

final class LevelViewController: BaseViewController {
    
    // MARK: - properties
    private let levelView = LevelView()
    
    // MARK: - life cycles
    override func loadView() {
        view = levelView
    }
    
    // MARK: - methods
    override func configureStyle() {
        configureNavigation()
    }
    
    override func configureAddTarget() {
        levelView.okBarButtonItem.target = self
        levelView.okBarButtonItem.action = #selector(tappedOkBarButtonItem)
    }
    
    private func configureNavigation() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = levelView.okBarButtonItem
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc
    private func tappedOkBarButtonItem() {
        print(#function)
    }
}
