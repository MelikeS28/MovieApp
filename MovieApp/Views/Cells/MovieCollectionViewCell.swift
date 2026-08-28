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

// MARK: - Delegate

protocol MovieCollectionViewCellDelegate: AnyObject {
    func didTapHeartButton(on movie: Movie)
}

final class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: MovieCollectionViewCellDelegate?
    private var currentMovie: Movie?
    
    static let identifier = "MovieCollectionViewCell"
    
    // MARK: - UI Elements
    
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
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let image = UIImage(systemName: "heart.fill", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = .systemRed
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleLabel.text = nil
        ratingLabel.text = nil
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .systemGray
        currentMovie = nil
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(heartButton)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
        
    }
    
    // MARK: - Setup Contraints
    
    private func setupConstraints(){
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(8)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(8).priority(.low)
        }
        
        heartButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(12)
            make.width.equalTo(32)
        }
    }
    
    // MARK: - Configuration
    
    func configure(with movie: Movie) {
        self.currentMovie = movie
        titleLabel.text = movie.title
        ratingLabel.text  = String(format: "★ %.1f", movie.voteAverage)
        
        posterImageView.sd_setImage(with: movie.postURL, placeholderImage: UIImage(systemName: "film"))
        
        if movie.isFavorite ?? false {
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            heartButton.tintColor = .systemRed
        } else {
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            heartButton.tintColor = .systemGray
        }
    }
    
    // MARK: - Actions
    
    @objc private func heartButtonTapped() {
        guard let movie = currentMovie else { return }
        delegate?.didTapHeartButton(on: movie)
    }
}
