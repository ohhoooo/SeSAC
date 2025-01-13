//
//  MovieSearchTableViewCell.swift
//  SeSAC-AutoLayout
//
//  Created by 김정호 on 1/13/25.
//

import UIKit
import SnapKit

final class MovieSearchTableViewCell: UITableViewCell {
    
    // MARK: - properties
    static let identifier = "MovieSearchViewController"
    
    private let rankLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    // MARK: - life cycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .black
        
        configureHierarchy()
        configureConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - methods
    private func configureHierarchy() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func configureConstraint() {
        rankLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(44)
            $0.height.equalTo(28)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(24)
            $0.trailing.equalTo(dateLabel.snp.leading).offset(-16)
            $0.centerY.equalTo(rankLabel)
        }
        
        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(rankLabel)
        }
    }
    
    func configureData(movie: Movie) {
        rankLabel.text = "\(movie.rank)"
        titleLabel.text = movie.title
        dateLabel.text = movie.date
    }
}
