//
//  MoviesTableViewController.swift
//  MovieApp
//
//  Created by Dawid Szołucha on 06/01/2023.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    var movies: [Movie] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MovieCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            fatalError("Could not reuse cell with identifier: \(cellIdentifier)")
        }
        
        cell.movie = movies[indexPath.row]
        cell.titleLabel.text = movies[indexPath.row].title
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let destination = segue.destination as? MovieViewController else { return }
        guard let cell = sender as? MovieTableViewCell else { return }
        
        destination.movie = cell.movie
    }
}
