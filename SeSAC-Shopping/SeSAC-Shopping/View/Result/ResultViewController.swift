//
//  ResultViewController.swift
//  SeSAC-Shopping
//
//  Created by 김정호 on 1/15/25.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift
import Toast

final class ResultViewController: BaseViewController {
    
    // MARK: - properties
    private let resultView = ResultView()
    private let viewModel: ResultViewModel
    
    private let realm = try! Realm()
    private var list: Results<Like>!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list = realm.objects(Like.self)
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
            ) { [weak self] (row, element, cell) in
                guard let self, let id = element.productId else { return }
                
                cell.configureData(item: element)
                cell.bindLike(like: !list.filter { $0.productId == id }.isEmpty)
                
                cell.likeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        guard let id = element.productId else { return }
                        
                        if owner.list.filter({ $0.productId == id }).isEmpty {
                            do {
                                try owner.realm.write {
                                    let like = Like(
                                        title: element.title,
                                        image: element.image,
                                        price: element.price,
                                        mallName: element.mallName,
                                        productId: id
                                    )
                                    
                                    owner.realm.add(like)
                                    owner.presentToast(message: "\(like.title ?? "알 수 없음")이 추가되었습니다.")
                                }
                            } catch {
                                print("추가 실패")
                            }
                        } else {
                            do {
                                try owner.realm.write {
                                    let like = Array(owner.list.filter({ $0.productId == id }))
                                    let title = like.first?.title
                                    
                                    owner.realm.delete(like)
                                    owner.presentToast(message: "\(title ?? "알 수 없음")이 삭제되었습니다.")
                                }
                            } catch {
                                print("삭제 실패")
                            }
                        }
                        
                        owner.resultView.collectionView.reloadData()
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
    }
}
