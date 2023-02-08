//
//  Movie.swift
//  MovieApp
//
//  Created by Dawid Szołucha on 30/12/2022.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let plot: String
    let posterUrl: String
    let genres: [String]
}
