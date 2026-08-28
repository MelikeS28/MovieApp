//
//  ViewController.swift
//  MovieApp
//
//  Created by Melike on 20.04.2026.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel = MovieListViewModel()
    
    // MARK: - UI Elements
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .systemBackground
        setupUI()
        setupCollectionView()
        
        viewModel.getMovies { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        title = "Popular Movies"
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }

}

// MARK: - UICollectionView DataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        var movie = viewModel.movies[indexPath.row]
        movie.isFavorite = FavoritesViewModel.shared.isMovieFavorite(id: movie.id)
        
        cell.configure(with: movie)
        cell.delegate = self
        return cell
    }
}

// MARK: - UICollectionView Delegate & FlowLayout

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.row]
        let detailViewModel = DetailViewModel(movie: selectedMovie)
        let detailVC = DetailViewController()
        detailVC.configure(with: detailViewModel)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cellWidth = (width - 30) / 2
        return CGSize(width: cellWidth, height: cellWidth * 1.5)
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
}

// MARK: - MovieCollectionViewCellDelegate

extension ViewController: MovieCollectionViewCellDelegate {
    
    func didTapHeartButton(on movie: Movie) {
        FavoritesViewModel.shared.toggleFavorite(movie)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
        }
    }
}
