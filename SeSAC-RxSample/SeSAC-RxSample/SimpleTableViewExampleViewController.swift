//
//  SimpleTableViewExampleViewController.swift
//  SeSAC-RxSample
//
//  Created by 김정호 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class SimpleTableViewExampleViewController: UIViewController {
    
    // MARK: - properties
    private let tableView = UITableView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        configureTableView()
    }
    
    // MARK: - methods
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element) @ row \(row)"
                cell.accessoryType = .detailButton
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .modelSelected(String.self)
            .subscribe(with: self) { owner, value in
                owner.showAlert(title: "modelSelected", message: "Tapped \(value)")
            }
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .itemAccessoryButtonTapped
            .subscribe(with: self) { owner, value in
                owner.showAlert(title: "itemAccessoryButtonTapped", message: "Tapped \(value)")
            }
            .disposed(by: disposeBag)
    }
    
    private func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alertVC.addAction(ok)
        present(alertVC, animated: true)
    }
}
