//
//  ViewController.swift
//  MovieApp
//
//  Created by Melike on 20.04.2026.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        viewModel.getMovies { [weak self] in
            DispatchQueue.main.async {
            }
        }
    }
}

