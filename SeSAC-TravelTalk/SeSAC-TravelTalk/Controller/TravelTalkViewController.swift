//
//  ViewController.swift
//  SeSAC-TravelTalk
//
//  Created by 김정호 on 1/10/25.
//

import UIKit

final class TravelTalkViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet private weak var travelTalkSearchBar: UISearchBar!
    @IBOutlet private weak var travelTalkCollectionView: UICollectionView!
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureSearchBar()
        configureNavigation()
        configureCollectionView()
    }
    
    private func configureSearchBar() {
        travelTalkSearchBar.placeholder = "친구 이름을 검색해보세요"
    }
    
    private func configureNavigation() {
        navigationItem.title = "TRAVEL TALK"
    }
    
    private func configureCollectionView() {
        let nib = UINib(nibName: "TravelTalkCollectionViewCell", bundle: nil)
        travelTalkCollectionView.register(nib, forCellWithReuseIdentifier: TravelTalkCollectionViewCell.identifier)
        travelTalkCollectionView.delegate = self
        travelTalkCollectionView.dataSource = self
        travelTalkCollectionView.collectionViewLayout = createFlowLayout()
    }
}

// MARK: - extensions
extension TravelTalkViewController {
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 72)
        return layout
    }
}

extension TravelTalkViewController: UICollectionViewDelegate {
    // To Do
}

extension TravelTalkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockChatList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.identifier, for: indexPath) as? TravelTalkCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(chatRoom: mockChatList[indexPath.row])
        
        return cell
    }
}
