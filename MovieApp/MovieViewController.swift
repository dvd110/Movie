//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Dawid Szołucha on 29/12/2022.
//

import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLoaderView: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var task: URLSessionDataTask?
    var movie: Movie?
    
    deinit {
        task?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = movie?.title
        
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.plot
        
        if let uri = movie?.posterUrl, let url = URL(string: uri) {
            task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
                
                DispatchQueue.main.async {
                    if let data = data {
                        self?.imageView.image = UIImage(data: data)
                        self?.imageLoaderView.stopAnimating()
                    } else {
                        self?.imageLoaderView.stopAnimating()
                    }
                }
            }
            task?.resume()
        }
    }
    
}
