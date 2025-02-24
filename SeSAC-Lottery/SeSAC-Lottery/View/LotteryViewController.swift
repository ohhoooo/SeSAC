//
//  LotteryViewController.swift
//  SeSAC-Lottery
//
//  Created by 김정호 on 1/14/25.
//

import UIKit
import RxSwift
import RxCocoa

final class LotteryViewController: UIViewController {
    
    // MARK: - properties
    private let lotteryView = LotteryView()
    private let viewModel = LotteryViewModel()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    override func loadView() {
        view = lotteryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureAddTarget()
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lotteryView.sizeCornerRadius()
    }
    
    // MARK: - methods
    private func configureAddTarget() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedTapGesture)))
    }
    
    private func bind() {
        let input = LotteryViewModel.Input(
            modelSelected: lotteryView.pickerView.rx.modelSelected(String.self),
            tapObservableButton: lotteryView.observableButton.rx.tap,
            tapSingleButton: lotteryView.singleButton.rx.tap
        )
        
        let output = viewModel.transform(input: input)
        
        output.drwNoTitles
            .bind(to: lotteryView.pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        output.lottery
            .subscribe(with: self) { owner, value in
                owner.lotteryView.configureData(lottery: value)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("lottery: onCompleted")
            } onDisposed: { owner in
                print("lottery: onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    @objc
    private func tappedTapGesture() {
        view.endEditing(true)
    }
}
