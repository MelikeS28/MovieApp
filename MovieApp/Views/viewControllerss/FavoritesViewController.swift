//
//  FavoritesViewController.swift
//  MovieApp
//
//  Created by Melike on 16.06.2026.
//

import UIKit
import SDWebImage
import SnapKit

final class FavoritesViewController: UIViewController {
 
    // MARK: - Properties
    
    private var viewModel = FavoritesViewModel.shared
    
    // MARK: - UI Elements
    
    private let tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableview
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            viewModel.fetchFavoriteMovies()
            tableView.reloadData() 
        }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

// MARK: - TableView DataSource

extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currentMovie = viewModel.movie(at: indexPath.row)
        
        cell.textLabel?.text = currentMovie.title
        cell.imageView?.sd_setImage(with: currentMovie.postURL, placeholderImage: UIImage(systemName: "Movie"))
        
        return cell
    }
    
}
// MARK: - TableView Delegate

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movie(at: indexPath.row)
        let detailViewModel = DetailViewModel(movie: selectedMovie)
        
        let detailVC = DetailViewController()
        detailVC.configure(with: detailViewModel)
        
        navigationController?.pushViewController(detailVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
