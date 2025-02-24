//
//  LotteryViewModel.swift
//  SeSAC-Lottery
//
//  Created by 김정호 on 2/25/25.
//

import Foundation
import RxSwift
import RxCocoa

final class LotteryViewModel {
    
    // MARK: - properties
    struct Input {
        let modelSelected: ControlEvent<[String]>
        let tapObservableButton: ControlEvent<Void>
        let tapSingleButton: ControlEvent<Void>
    }
    
    struct Output {
        let drwNoTitles: BehaviorSubject<[String]>
        let lottery: PublishSubject<Lottery>
    }
    
    private let drwNoTitles = BehaviorSubject<[String]>(value: [])
    private let lottery = PublishSubject<Lottery>()
    
    private var drwNo = ""
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycles
    init() {
        initLottery()
    }
    
    // MARK: - methods
    func transform(input: Input) -> Output {
        input.modelSelected
            .compactMap { $0.first }
            .do {
                self.drwNo = $0
            }
            .flatMap {
                NetworkManager.shared.fetchObservableLottery(drwNo: $0)
            }
            .bind(with: self) { owner, value in
                owner.lottery.onNext(value)
            }
            .disposed(by: disposeBag)
        
        input.tapObservableButton
            .flatMap {
                NetworkManager.shared.fetchObservableLottery(drwNo: self.drwNo)
            }
            .subscribe(with: self) { owner, value in
                owner.lottery.onNext(value)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("tapObservableButton: onCompleted")
            } onDisposed: { owner in
                print("tapObservableButton: onDisposed")
            }
            .disposed(by: disposeBag)
        
        input.tapSingleButton
            .flatMap {
                NetworkManager.shared.fetchSingleLottery(drwNo: self.drwNo)
            }
            .subscribe(with: self) { owner, value in
                owner.lottery.onNext(value)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("tapSingleButton: onCompleted")
            } onDisposed: { owner in
                print("tapSingleButton: onDisposed")
            }
            .disposed(by: disposeBag)
        
        return Output(
            drwNoTitles: drwNoTitles,
            lottery: lottery
        )
    }
    
    private func initLottery() {
        let latestDrwNo = fetchLatestDrwNo()
        
        drwNoTitles.onNext((1...latestDrwNo).map { String($0) }.reversed())
        
        NetworkManager.shared.fetchObservableLottery(drwNo: String(latestDrwNo))
            .subscribe(with: self) { owner, value in
                owner.lottery.onNext(value)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("fetchObservableLottery: onCompleted")
            } onDisposed: { owner in
                print("fetchObservableLottery: onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchLatestDrwNo() -> Int {
        let calendar = Calendar.current
        
        var dateComponents = DateComponents(year: 2002, month: 12, day: 7)
        dateComponents.calendar = calendar
        guard let startDate = dateComponents.date else { return -1 }
        
        let today = Date()
        
        let weekday = calendar.component(.weekday, from: today)
        let saturday = (7 - weekday) % 7
        guard let latestSaturday = calendar.date(byAdding: .day, value: saturday, to: today) else { return -1 }
        
        let day = calendar.dateComponents([.day], from: startDate, to: latestSaturday).day ?? 0
        let drwNo = day / 7
        
        return (today < latestSaturday) ? drwNo : drwNo + 1
    }
}
