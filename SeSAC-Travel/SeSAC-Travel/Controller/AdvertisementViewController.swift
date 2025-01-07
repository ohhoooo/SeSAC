//
//  AdvertisementViewController.swift
//  SeSAC-Travel
//
//  Created by 김정호 on 1/8/25.
//

import UIKit

final class AdvertisementViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var adTitleLabel: UILabel!
    
    var adText: String?
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabel()
        configureNavigation()
    }
    
    // MARK: - methods
    private func configureLabel() {
        adTitleLabel.text = adText
        adTitleLabel.font = .boldSystemFont(ofSize: 20)
        adTitleLabel.numberOfLines = 3
        adTitleLabel.textAlignment = .center
    }
    
    private func configureNavigation() {
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.title = "광고 화면"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(tappedBackButton))
    }
    
    @objc
    private func tappedBackButton() {
        dismiss(animated: true)
    }
}
