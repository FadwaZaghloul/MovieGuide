//
//  TrailersDelegate.swift
//  MovieGuide
//
//  Created by Fadwa Zaghloul on 4/13/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol TrailersDelegate: class {
    func setMovieTrailers(trailers: [String])
    
    func reloadTrailersData()
}
