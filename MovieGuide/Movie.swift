//
//  Movie.swift
//  MovieGuide
//
//  Created by Fadwa Zaghloul on 4/5/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

class Movie {
    var id = 0
    var originalTitle = ""
    var poster = ""
    var synopsis = ""
    var rating = 0.0
    var releaseDate = ""
    var trailersKeys = [String]()
    var addedToCoreData: Bool = false
}
