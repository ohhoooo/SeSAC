//
//  OnboardingViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/24/25.
//

import UIKit

final class OnboardingViewController: BaseViewController {
    
    // MARK: - properties
    private let onboardingView = OnboardingView()
    
    // MARK: - life cycles
    override func loadView() {
        view = onboardingView
    }
    
    // MARK: - methods
    override func configureAddTarget() {
        onboardingView.button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    
    @objc
    private func tappedButton() {
        print(#function)
    }
}
