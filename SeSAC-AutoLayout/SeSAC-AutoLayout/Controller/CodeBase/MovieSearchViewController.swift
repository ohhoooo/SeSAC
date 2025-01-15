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
        tf.text = "20250113"
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
    
    private let networkManager = NetworkManager.shared
    
    private var movie: Movie? {
        didSet {
            movieTableView.reloadData()
        }
    }
    
    // MARK: - life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        configureUI()
        configureHierarchy()
        configureConstraint()
        configureData()
    }
    
    // MARK: - methods
    private func configureUI() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(MovieSearchTableViewCell.self, forCellReuseIdentifier: MovieSearchTableViewCell.identifier)
        
        searchButton.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
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
    
    private func configureData(date: String = "20250113") {
        networkManager.fetchMovieList(date: date) { result in
            switch result {
            case .success(let movie):
                self.movie = movie
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    private func tappedSearchButton(_ sender: UIButton) {
        guard let date = textField.text else { return }
        configureData(date: date)
    }
}

// MARK: - extensions
extension MovieSearchViewController: UITableViewDelegate {
    
}

extension MovieSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie?.boxOfficeResult.dailyBoxOfficeList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieSearchTableViewCell.identifier, for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        cell.configureData(movie: movie?.boxOfficeResult.dailyBoxOfficeList[indexPath.row])
        
        return cell
    }
}
