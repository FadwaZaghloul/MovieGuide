//
//  MoviesConnectorToApi.swift
//  MovieGuide
//
//  Created by Fadwa Zaghloul on 4/10/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import Foundation
import Alamofire

class MoviesConnectorToApi {
    
    weak var home: HomeDelegate?
    var result = [Dictionary<String, AnyObject>]()
    var jsonRes = [String: AnyObject]()
    var popularMovies = [Movie]()
    var topRatedMovies = [Movie]()
    var requestType: String = "popular"
    var isFirstTimeToRequestPop: Bool = true
    var isFirstTimeToRequestTopRated: Bool = true
    var trailersUrl: String = ""
    var movieDetailsView: TrailersDelegate?
 
    func getNewPageOfMovies(url: String) {

        if url.range(of:"popular") != nil {
            requestType = "popular"
        } else {
            requestType = "topRated"
        }
        
        if requestType == "popular" && isFirstTimeToRequestPop == false {
            self.home?.setMovies(moviesRes: self.popularMovies)
            self.home?.reloadColletionViewData()
        }
        
        else if requestType == "topRated" && isFirstTimeToRequestTopRated == false {
            self.home?.setMovies(moviesRes: self.topRatedMovies)
            self.home?.reloadColletionViewData()
        }
        
        else {
            Alamofire.request(url).responseJSON { response in
            
                if let json = response.result.value {
                    self.jsonRes = json as! Dictionary<String, AnyObject>
                    self.result = self.jsonRes["results"] as! Array<Dictionary<String, AnyObject>>

                    for index in 0...self.result.count-1 {
                        let movie: Movie = Movie()
                        movie.id = self.result[index]["id"]! as! Int
                        movie.originalTitle = self.result[index]["original_title"]! as! String
                        movie.rating = self.result[index]["vote_average"]! as! Double
                        movie.releaseDate = self.result[index]["release_date"]! as! String
                        movie.synopsis = self.result[index]["overview"]! as! String
                        movie.poster = "http://image.tmdb.org/t/p/w185" + (self.result[index]["poster_path"]! as! String)
                        
                        if self.requestType == "popular" {
                            self.popularMovies.append(movie)
                        } else {
                            self.topRatedMovies.append(movie)
                        }
                        
                    }
                }
                
                if self.requestType == "popular" {
                    self.home?.setMovies(moviesRes: self.popularMovies)
                    self.isFirstTimeToRequestPop = false
                } else {
                    self.home?.setMovies(moviesRes: self.topRatedMovies)
                    self.isFirstTimeToRequestTopRated = false
                }
                
                self.home?.reloadColletionViewData()
            }
        }
    }
    
    func getMovieTrailers (movieId: Int) {
        trailersUrl = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=8ed1eff8459c80e18ebd8171bc2c3c8a&language=en-US"
        
        var movieTrailers = [String]()

        Alamofire.request(trailersUrl).responseJSON { response in
            
            if let json = response.result.value {
                self.jsonRes = json as! Dictionary<String, AnyObject>
                self.result = self.jsonRes["results"] as! Array<Dictionary<String, AnyObject>>

                for index in 0...self.result.count-1 {
                    movieTrailers.append(self.result[index]["key"]! as! String)
                    
                }
            }
            self.movieDetailsView?.setMovieTrailers(trailers: movieTrailers)
            DispatchQueue.main.async {
                self.movieDetailsView?.reloadTrailersData()
            }
        }
    }
}
