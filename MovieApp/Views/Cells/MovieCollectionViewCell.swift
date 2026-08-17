//
//  MovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Melike on 2.06.2026.
//
import Foundation
import UIKit
import SnapKit
import SDWebImage

final class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionViewCell"
    
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let titleLabel :  UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
            make.bottom.lessThanOrEqualToSuperview().inset(8)
        }
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.title
        
        if let posterPath = movie.posterPath {
            let urlString = "https://image.tmdb.org/t/p/w500/\(posterPath)"
            let url = URL(string: urlString)
            posterImageView.sd_setImage(with: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
