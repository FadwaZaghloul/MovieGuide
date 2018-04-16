//
//  ViewController.swift
//  MovieGuide
//
//  Created by Fadwa Zaghloul on 4/4/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import SDWebImage
import Dropdowns

private let reuseIdentifier = "MovieCell"
private var popMoviesPageNumber = "1"
private var topRatedMoviesPageNumber = "1"
public var popMoviesUrl = "https://api.themoviedb.org/3/movie/popular?api_key=8ed1eff8459c80e18ebd8171bc2c3c8a&language=en-US&page="
public var topRatedMoviesUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key=8ed1eff8459c80e18ebd8171bc2c3c8a&language=en-US&page="
let sectionInsets = UIEdgeInsets(top: 0.0, left: 1.5, bottom: 0.0, right: 0.0);
let numberOfItemsPerRow : CGFloat = 2;

class HomeViewController: UIViewController, HomeDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    
    var connector: MoviesConnectorToApi = MoviesConnectorToApi()
    var movies = [Movie]()
    
    
    func reloadColletionViewData() {
        self.moviesCollection.reloadData()
    }
    
    
    func setMovies(moviesRes: [Movie]) {
        movies = moviesRes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        connector.home = self
        connector.getNewPageOfMovies(url: popMoviesUrl + popMoviesPageNumber)

        let items = ["Most Popular Movies", "Top Rated Movies"]
        let titleView = TitleView(navigationController: navigationController!, title: "Movies", items: items)
        
        titleView?.action = { [weak self] index in
            
            //Most Popular Movies
            if index == 0 {
                self?.connector.getNewPageOfMovies(url: popMoviesUrl + popMoviesPageNumber)
            }
            
            //Top Rated Movies
            else {
                self?.connector.getNewPageOfMovies(url: topRatedMoviesUrl + topRatedMoviesPageNumber)
            }
        }
        
        navigationItem.titleView = titleView
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as UICollectionViewCell
        //print(movies[indexPath.row].poster)
        (cell.contentView.viewWithTag(1) as! UIImageView).sd_setImage(with: URL(string: movies[indexPath.row].poster), placeholderImage: UIImage(named: "default-image.png"))

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsView = self.storyboard?.instantiateViewController(withIdentifier: "movieDetailsView") as! MovieDetailsViewController
        detailsView.movieToShow = movies[indexPath.row]
        self.navigationController?.pushViewController(detailsView, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (numberOfItemsPerRow);
        let availableWidth = view.frame.width - paddingSpace;
        let widthPerItem = availableWidth / numberOfItemsPerRow;
        return CGSize(width: widthPerItem, height: widthPerItem);
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets;
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left;
    }
}

