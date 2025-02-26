//
//  ResultViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit
import RxSwift
import RxCocoa

final class ResultViewController: BaseViewController {
    
    // MARK: - properties
    private let resultView = ResultView()
    private let viewModel: ResultViewModel
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    init(viewModel: ResultViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = resultView
    }
    
    // MARK: - methods
    override func bind() {
        let input = ResultViewModel.Input(
            tapAccuracyButton: resultView.accuracyButton.rx.tap,
            tapDateButton: resultView.dateButton.rx.tap,
            tapSortByHighPriceButton: resultView.sortByHighPriceButton.rx.tap,
            tapSortByLowPriceButton: resultView.sortByLowPriceButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.title
            .bind(with: self) { owner, value in
                owner.navigationItem.title = value
                owner.navigationController?.navigationBar.tintColor = .black
                owner.navigationController?.navigationBar.topItem?.title = ""
            }
            .disposed(by: disposeBag)
        
        output.tag
            .bind(with: self) { owner, value in
                owner.resultView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                owner.resultView.changeButtonColor(tag: value)
            }
            .disposed(by: disposeBag)
        
        output.count
            .bind(with: self) { owner, value in
                owner.resultView.configureData(total: value)
            }
            .disposed(by: disposeBag)
        
        output.error
            .bind(with: self) { owner, value in
                owner.showAlert(title: "알림", message: value, button: "확인")
            }
            .disposed(by: disposeBag)
        
        output.items
            .bind(to: resultView.collectionView.rx.items(
                cellIdentifier: ResultCollectionViewCell.identifier,
                cellType: ResultCollectionViewCell.self)
            ) { (row, element, cell) in
                cell.configureData(item: element)
            }
            .disposed(by: disposeBag)
    }
}
