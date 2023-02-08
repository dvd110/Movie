//
//  Response.swift
//  MovieApp
//
//  Created by Dawid Szołucha on 13/01/2023.
//

import Foundation

struct Response: Decodable {
    let genres: [String]
    let movies: [Movie]
}
