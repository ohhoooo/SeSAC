//
//  LotteryViewController.swift
//  SeSAC-Lottery
//
//  Created by 김정호 on 1/14/25.
//

import UIKit

final class LotteryViewController: UIViewController {
    
    // MARK: - properties
    private let lotteryView = LotteryView()
    private let networkManager = NetworkManager.shared
    
    private var lottery: Lottery? {
        didSet {
            guard let lottery else { return }
            lotteryView.configureData(lottery: lottery)
        }
    }
    
    // MARK: - life cycles
    override func loadView() {
        view = lotteryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        lotteryView.sizeCornerRadius()
    }
}

// MARK: - extension
extension LotteryViewController {
    private func configureUI() {
        configureView()
        configurePickerView()
    }
    
    private func configureView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedTapGesture)))
    }
    
    private func configurePickerView() {
        lotteryView.pickerView.delegate = self
        lotteryView.pickerView.dataSource = self
    }
    
    private func configureData(drwNo: String = "1154") {
        networkManager.fetchLottery(drwNo: drwNo) { result in
            switch result {
            case .success(let lottery):
                self.lottery = lottery
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    private func tappedTapGesture() {
        view.endEditing(true)
    }
}

extension LotteryViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(1154 - row)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        configureData(drwNo: "\(1154 - row)")
    }
}

extension LotteryViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lottery?.drwNo ?? 1
    }
}
