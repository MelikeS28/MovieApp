//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Melike on 15.06.2026.
//

import UIKit
import SnapKit
import SDWebImage

final class DetailViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel: DetailViewModel?
    
    // MARK: - UI Elements
    
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .systemOrange
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(backdropImageView)
        view.addSubview(titleLabel)
        view.addSubview(ratingLabel)
        view.addSubview(overviewLabel)
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        
        backdropImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
    }
    
    // MARK: - Configuration
    
    func configure(with viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.titleMovie
        overviewLabel.text = viewModel.overviewMovieText
        ratingLabel.text = "★ \(viewModel.raitingMovie)"
        
        if let url = viewModel.posterURL {
            backdropImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
