//
//  UserViewController.swift
//  SeSAC-ViewModel
//
//  Created by 김정호 on 2/5/25.
//

import UIKit
import SnapKit

final class UserViewController: UIViewController {
    
    // MARK: - properties
    private let tableView: UITableView = {
        let table = UITableView()
        table.rowHeight = 60
        table.register(UITableViewCell.self, forCellReuseIdentifier: "PersonCell")
        return table
    }()
    
    private let loadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Load", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loadButton, resetButton, addButton])
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let viewModel = UserViewModel()
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupTableView()
        setupActions()
        bind()
    }
    
    // MARK: - methods
    private func setupUI() {
        view.backgroundColor = .white
        title = "Person List"
        
        [buttonStackView, tableView].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupActions() {
        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.person.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    @objc private func loadButtonTapped() {
        viewModel.inputLoadButtonTapped.value = ()
    }
    
    @objc private func resetButtonTapped() {
        viewModel.inputResetButtonTapped.value = ()
    }
    
    @objc private func addButtonTapped() {
        viewModel.inputAddButtonTapped.value = ()
    }
}

// MARK: - extensions
extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            self?.viewModel.inputDeleteButtonTapped.value = indexPath
            success(true)
        }
        
        delete.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.person.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        let person = viewModel.person.value[indexPath.row]
        cell.textLabel?.text = "\(person.name), \(person.age)세"
        return cell
    }
}
