//
//  FolderViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 3/5/25.
//

import UIKit
import RxSwift
import RxCocoa

final class FolderViewController: BaseViewController {
    
    // MARK: - properties
    private let folderView = FolderView()
    private let viewModel = FolderViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func loadView() {
        view = folderView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigation()
        folderView.tableView.reloadData()
    }
    
    // MARK: - methods
    override func bind() {
        let input = FolderViewModel.Input(
            modelSelected: folderView.tableView.rx.modelSelected(Folder.self)
        )
        
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: folderView.tableView.rx.items(
                cellIdentifier: FolderCell.identifier,
                cellType: FolderCell.self)
            ) { (row, element, cell) in
                cell.bind(folder: element)
            }
            .disposed(by: disposeBag)
        
        output.modelSelected
            .bind(with: self) { owner, value in
                let wishListVM = WishListViewModel(id: value.id)
                let wishListVC = WishListViewController(viewModel: wishListVM)
                
                owner.navigationController?.pushViewController(wishListVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNavigation() {
        navigationItem.title = "폴더 목록"
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}
