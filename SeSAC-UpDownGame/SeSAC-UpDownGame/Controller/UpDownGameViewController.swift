//
//  UpDownGameViewController.swift
//  SeSAC-UpDownGame
//
//  Created by 김정호 on 1/9/25.
//

import UIKit

final class UpDownGameViewController: UIViewController {
    
    // MARK: - properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var gameCollectionView: UICollectionView!
    @IBOutlet private weak var resultButton: UIButton!
    
    var maxNumber: Int?
    private var count = 0
    private var selectedNumber: Int?
    private var selectedIndexPath: IndexPath?
    private lazy var range = Array(1...(maxNumber ?? 1))
    private lazy var answer = (1...(maxNumber ?? 1)).randomElement()
    
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
        
        subtitleLabel.text = "시도 횟수: \(count)"
        subtitleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleLabel.textAlignment = .center
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.title = "결과 확인하기"
        config.cornerStyle = .fixed
        config.contentInsets = .init(top: 16, leading: 0, bottom: 16, trailing: 0)
        config.baseBackgroundColor = .systemGray2
        config.baseForegroundColor = .white
        config.attributedTitle?.font = .boldSystemFont(ofSize: 16)
        config.background.cornerRadius = 0
        resultButton.configuration = config
        resultButton.isUserInteractionEnabled = false
    }
    
    private func configureCollectionView() {
        gameCollectionView.delegate = self
        gameCollectionView.dataSource = self
        gameCollectionView.backgroundColor = UIColor(red: 193/255, green: 218/255, blue: 255/255, alpha: 1)
        gameCollectionView.collectionViewLayout = createFlowLayout()
        gameCollectionView.register(UINib(nibName: "UpDownGameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: UpDownGameCollectionViewCell.identifier)
    }
    
    @IBAction private func tappedResultButton(_ sender: UIButton) {
        guard let answer, let selectedNumber else { return }
        
        count += 1
        resultButton.isUserInteractionEnabled = false
        resultButton.configuration?.baseBackgroundColor = .systemGray2
        
        switch selectedNumber {
        case answer:
            presentAlert(title: "알림", message: "정답입니다!", style: .alert)
        case 1..<answer:
            range = Array(selectedNumber + 1...range[range.count - 1])
            titleLabel.text = "UP"
            subtitleLabel.text = "시도 횟수: \(count)"
        default:
            range = Array(range[0]...selectedNumber - 1)
            titleLabel.text = "DOWN"
            subtitleLabel.text = "시도 횟수: \(count)"
        }
        
        self.selectedNumber = nil
        self.selectedIndexPath = nil
        gameCollectionView.reloadData()
    }
}

// MARK: - extensions
extension UpDownGameViewController {
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 55, height: 55)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 4)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    private func presentAlert(title: String, message: String, style: UIAlertController.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let check = UIAlertAction(title: "확인", style: .cancel) { _ in
            self.dismiss(animated: true)
        }
        alert.addAction(check)
        present(alert, animated: true)
    }
}

extension UpDownGameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? UpDownGameCollectionViewCell else { return }
        selectedNumber = selectedCell.fetchNumber()
        selectedIndexPath = indexPath
        resultButton.isUserInteractionEnabled = true
        resultButton.configuration?.baseBackgroundColor = .black
        collectionView.reloadData()
    }
}

extension UpDownGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return range.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpDownGameCollectionViewCell.identifier, for: indexPath) as? UpDownGameCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureData(text: "\(range[indexPath.row])", isSelected: (selectedIndexPath?.row == indexPath.row))
        
        return cell
    }
}
