//
//  ResultViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - properties
    private let resultView = ResultView()
    
    var keyword: String? {
        didSet {
            guard let keyword else { return }
            print(keyword)
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = resultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
}

// MARK: - extensions
extension ResultViewController {
    private func configureUI() {
        configureView()
        configureNavigation()
    }
    
    private func configureView() {
        
    }
    
    private func configureNavigation() {
        navigationItem.title = keyword
    }
}
