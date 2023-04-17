//
//  MovieListCollectionViewCell.swift
//  movieNote
//
//  Created by 이주상 on 2023/03/16.
//

import UIKit
import SnapKit
import Kingfisher

class MovieListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .secondarySystemBackground
        
        return imageView
    }()
    
    func update(_ movieNote: MovieNoteData) {
        setupView()
        setupLayout()
        if movieNote.jpegData != nil {
            imageView.image = UIImage(data: movieNote.jpegData!) ?? UIImage()
        } else {
            imageView.kf.setImage(with: movieNote.imageURL)
        }
    }
}

private extension MovieListCollectionViewCell {
    func setupView() {
        backgroundColor = .systemBackground
    }

    func setupLayout() {
        addSubview(imageView)

        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
