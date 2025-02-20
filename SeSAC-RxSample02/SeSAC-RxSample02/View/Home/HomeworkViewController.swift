//
//  HomeworkViewController.swift
//  SeSAC-RxSample02
//
//  Created by 김정호 on 2/19/25.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeworkViewController: UIViewController {
    
    // MARK: - properties
    private let homeworkView = HomeworkView()
    private let viewModel = HomeworkViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func loadView() {
        view = homeworkView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        bind()
    }
    
    // MARK: - methods
    private func configureNavigation() {
        navigationItem.titleView = homeworkView.searchBar
    }
    
    private func bind() {
        let input = HomeworkViewModel.Input(
            changedText: homeworkView.searchBar.rx.text,
            searchButtonClicked: homeworkView.searchBar.rx.searchButtonClicked,
            modelSelected: homeworkView.tableView.rx.modelSelected(Person.self)
        )
        
        let output = viewModel.transform(input: input)
        
        output.collectionViewPersons
            .bind(to: homeworkView.collectionView.rx.items(
                cellIdentifier: UserCollectionViewCell.identifier,
                cellType: UserCollectionViewCell.self)
            ) { row, element, cell in
                cell.label.text = element.name
            }
            .disposed(by: disposeBag)
        
        output.tableViewPersons
            .bind(to: homeworkView.tableView.rx.items(
                cellIdentifier: PersonTableViewCell.identifier,
                cellType: PersonTableViewCell.self)
            ) { row, element, cell in
                cell.usernameLabel.text = element.name
                cell.profileImageView.kf.setImage(with: URL(string: element.profileImage)!)
                cell.detailButton.rx.tap
                    .bind(with: self) { owner, _ in
                        let detailVC = DetailViewController()
                        detailVC.navigationItem.title = element.name
                        owner.navigationController?.pushViewController(detailVC, animated: true)
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
}
