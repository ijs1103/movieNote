//
//  MovieSearchTableViewCell.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/19.
//

import SnapKit
import UIKit
import Kingfisher

final class MovieSearchTableViewCell: UITableViewCell {
    
    static let identifier = "MovieSearchTableViewCell"

    private lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground

        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)

        return label
    }()

    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10.0, weight: .medium)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func update(_ movie: Movie) {
        setupView()
        setupLayout()
        
        movieImage.kf.setImage(with: movie.imageURL)
        titleLabel.text = movie.title.htmlToString
        yearLabel.text = movie.pubDate
    }

}

extension MovieSearchTableViewCell {
    
    func setupView() {
        backgroundColor = .systemBackground
    }
    
    func setupLayout() {
        [ movieImage, titleLabel, yearLabel ].forEach {
            addSubview($0)
        }
        
        let inset: CGFloat = 8.0
        
        movieImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(inset)
            $0.top.equalToSuperview().inset(inset)
            $0.bottom.equalToSuperview().inset(inset)
            $0.height.equalTo(60.0)
            $0.height.equalTo(movieImage.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(movieImage.snp.top)
            $0.leading.equalTo(movieImage.snp.trailing).offset(inset)
            $0.trailing.equalToSuperview().inset(inset)
        }
        
        yearLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.bottom.equalTo(movieImage.snp.bottom)
        }
    }
}
