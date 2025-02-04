//
//  PhotoViewController.swift
//  SeSAC-LocationAuthority
//
//  Created by 김정호 on 2/4/25.
//

import UIKit
import SnapKit
import PhotosUI

final class PhotoViewController: UIViewController {
    
    // MARK: - properties
    private let plusBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.style = .done
        barButtonItem.image = UIImage(systemName: "plus")
        return barButtonItem
    }()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    var completion: ((UIImage?) -> Void)?
    
    private var images: [UIImage] = []
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureDelegate()
        configureAddTarget()
    }
    
    // MARK: - methods
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = plusBarButtonItem
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    private func configureDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }
    
    private func configureAddTarget() {
        plusBarButtonItem.target = self
        plusBarButtonItem.action = #selector(tappedPlusBarButtonItem)
    }
    
    @objc
    private func tappedPlusBarButtonItem() {
        var configuration = PHPickerConfiguration()
        configuration.mode = .default
        configuration.filter = .images
        configuration.selectionLimit = 3
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        
        present(picker, animated: true)
    }
}

// MARK: - extensions
extension PhotoViewController {
    private func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width / 3
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        
        return layout
    }
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        completion?(images[indexPath.item])
        navigationController?.popViewController(animated: true)
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        cell.bind(image: images[indexPath.item])
        
        return cell
    }
}

extension PhotoViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        images = []
        
        for result in results {
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async { [weak self] in
                        self?.images.append(image as! UIImage)
                        self?.collectionView.reloadData()
                    }
                }
            }
        }
        
        dismiss(animated: true)
    }
}
