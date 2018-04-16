//
//  HomeDelegate.swift
//  MovieGuide
//
//  Created by Fadwa Zaghloul on 4/10/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation

protocol HomeDelegate: class {
    
    func reloadColletionViewData()
    
    func setMovies(moviesRes: [Movie])
}
