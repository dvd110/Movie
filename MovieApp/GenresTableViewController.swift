//
//  GenresTableViewController.swift
//  MovieApp
//
//  Created by Dawid Szołucha on 18/01/2023.
//

import UIKit

class GenresTableViewController: UITableViewController {
    private var task: URLSessionDataTask?
    private var response: Response?
    
    deinit {
        task?.cancel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://raw.githubusercontent.com/erik-sytnyk/movies-list/master/db.json")
        
        if let url = url {
            task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URLRequest(url: url)) { [weak self] data, response, error in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self?.parse(data: data)
                }
            }
            task?.resume()
        }
    }
    
    func parse(data: Data) {
        do {
            response = try JSONDecoder().decode(Response.self, from: data)
            tableView.reloadData()
        } catch let error {
            print(error)
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return response?.genres.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "GenreCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? GenreTableViewCell else {
            fatalError("Could not reuse cell with identifier: \(cellIdentifier)")
        }
        
        cell.genre = response?.genres[indexPath.row]
        cell.titleLabel.text = response?.genres[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let destination = segue.destination as? MoviesTableViewController else { return }
        guard let cell = sender as? GenreTableViewCell else { return }
        
        destination.movies = response?.movies.filter({ movie in
            guard let genre = cell.genre else { return false }
            return movie.genres.contains(genre)
        }) ?? []
    }
}
