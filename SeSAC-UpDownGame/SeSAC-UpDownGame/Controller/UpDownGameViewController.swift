//
//  UpDownGameViewController.swift
//  SeSAC-UpDownGame
//
//  Created by 김정호 on 1/9/25.
//

import UIKit

final class UpDownGameViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var resultButton: UIButton!
    
    var maxNumber: Int?
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - methods
    private func configureUI() {
        configureView()
        configureLabel()
        configureButton()
        configureCollectionView()
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(red: 193/255, green: 218/255, blue: 255/255, alpha: 1)
    }
    
    private func configureLabel() {
        titleLabel.text = "UP DOWN"
        titleLabel.font = .systemFont(ofSize: 44, weight: .heavy)
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "시도 횟수: 0"
        subtitleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleLabel.textAlignment = .center
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.title = "결과 확인하기"
        config.cornerStyle = .fixed
        config.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 0)
        config.baseBackgroundColor = .black
        config.baseForegroundColor = .white
        config.attributedTitle?.font = .boldSystemFont(ofSize: 16)
        config.background.cornerRadius = 0
        resultButton.configuration = config
    }
    
    private func configureCollectionView() {
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.backgroundColor = UIColor(red: 193/255, green: 218/255, blue: 255/255, alpha: 1)
        gameCollectionView.collectionViewLayout = createFlowLayout()
        gameCollectionView.register(UINib(nibName: "UpDownGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: UpDownGameCollectionViewCell.identifier)
    }
}

// MARK: - extensions
extension UpDownGameViewController {
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 55, height: 55)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 4)
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension UpDownGameViewController: UICollectionViewDelegate {
    
}

extension UpDownGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxNumber ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpDownGameCollectionViewCell.identifier, for: indexPath) as? UpDownGameCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(text: "\(indexPath.row + 1)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // To Do
    }
}
