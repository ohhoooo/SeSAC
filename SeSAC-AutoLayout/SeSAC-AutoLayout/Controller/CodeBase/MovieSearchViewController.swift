//
//  MovieSearchViewController.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/13/25.
//

import UIKit
import SnapKit

final class MovieSearchViewController: UIViewController {
    
    // MARK: - properties
    private let textField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 19)
        tf.textColor = .white
        tf.borderStyle = .none
        tf.placeholder = "검색어를 입력하세요"
        return tf
    }()
    
    private let textFieldBasedView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let searchButton = {
        let btn = UIButton()
        btn.setTitle("검색", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        return btn
    }()
    
    private let movieTableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .lightGray
        return tv
    }()
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        configureUI()
        configureHierarchy()
        configureConstraint()
    }
    
    // MARK: - methods
    private func configureUI() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(MovieSearchTableViewCell.self, forCellReuseIdentifier: MovieSearchTableViewCell.identifier)
    }
    
    private func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(textFieldBasedView)
        view.addSubview(searchButton)
        view.addSubview(movieTableView)
    }
    
    private func configureConstraint() {
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalTo(searchButton)
        }
        
        textFieldBasedView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.bottom.equalTo(searchButton)
            $0.height.equalTo(3)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(44)
            $0.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(48)
            $0.width.equalTo(80)
        }
        
        movieTableView.snp.makeConstraints {
            $0.top.equalTo(textFieldBasedView.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
}

// MARK: - extensions
extension MovieSearchViewController: UITableViewDelegate {
    
}

extension MovieSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.identifier, for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configureData(movie: movieList[indexPath.row])
        
        return cell
    }
}
