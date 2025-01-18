//
//  PhotoSearchViewController.swift
//  SeSAC-Photo
//
//  Created by 김정호 on 1/18/25.
//

import UIKit

final class PhotoSearchViewController: BaseViewController {
    
    // MARK: - properties
    private let photoSearchView = PhotoSearchView()
    
    // MARK: - life cycles
    override func loadView() {
        view = photoSearchView
    }
    
    // MARK: - methods
}

// MARK: - extensions
