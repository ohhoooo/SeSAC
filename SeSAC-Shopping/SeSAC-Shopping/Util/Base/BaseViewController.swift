//
//  BaseViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/16/25.
//

import UIKit

protocol BaseViewControllerProtocol: AnyObject {
    func configureStyle()
    func configureDelegate()
    func configureAddTarget()
    func bind()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureStyle()
        configureDelegate()
        configureAddTarget()
        bind()
    }
    
    func configureStyle() { }
    
    func configureDelegate() { }
    
    func configureAddTarget() { }
    
    func bind() { }
}
