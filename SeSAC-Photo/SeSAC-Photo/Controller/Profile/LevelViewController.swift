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
    
    var level: Int?
    var delegate: LevelDelegate?
    
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
    
    override func bind() {
        levelView.configureData(level: level)
    }
    
    private func configureNavigation() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = levelView.okBarButtonItem
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    @objc
    private func tappedOkBarButtonItem() {
        delegate?.postLevel(level: levelView.segmentedControl.selectedSegmentIndex)
        
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        delegate?.postLevel(level: levelView.segmentedControl.selectedSegmentIndex)
    }
}
