//
//  ViewController.swift
//  MovieApp
//
//  Created by Melike on 20.04.2026.
//

import UIKit
import Alamofire
import SDWebImage
import SnapKit

class ViewController: UIViewController {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg")
            imageView.sd_setImage(with: url)
    }


}

