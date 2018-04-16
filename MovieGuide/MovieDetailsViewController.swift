//
//  MovieDetailsViewController.swift
//  MovieGuide
//
//  Created by Fadwa Zaghloul on 4/11/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit
import WCLShineButton
import YouTubePlayer

class MovieDetailsViewController: UITableViewController, TrailersDelegate {

    var favParam = WCLShineParams()
    var favBtnX: CGFloat = 0.0
    var favBtnY: CGFloat = 0.0
    //var videoPlayer = YouTubePlayerView(frame: playerFrame)
    //videoPlayer.loadVideoID("nfWlot6h_JM")
    var movieToShow:Movie =  Movie()
    var connector: MoviesConnectorToApi = MoviesConnectorToApi()
    let trailerReuseIdentifier: String = "TrailerCell"
    var movieTrailers: [String] = [String]()
    var trailersTable: UITableView = UITableView()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let trailerName: UILabel = UILabel()
    let movieTitleLbl: UILabel = MovieTitleLabel()
    let moviePoster: UIImageView = UIImageView()
    let releaseDateLbl: UILabel = UILabel()
    let synopsisLbl: UILabel = UILabel()
    
    func setMovieTrailers(trailers: [String]) {
        movieTrailers = trailers
        print("count \(movieTrailers.count)")

    }
    
    func reloadTrailersData() {
        print("reload")
        trailersTable.reloadData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        connector.movieDetailsView = self
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func addMovieToFav() {
        print("Hello Favorite")
        if movieToShow.addedToCoreData == false {
            //add to core data
            movieToShow.addedToCoreData = true
        }
        else {
            //remove from core data
            movieToShow.addedToCoreData = false
        }
    
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numOfRows: Int?
        if tableView == trailersTable {
            print("TrailersNumOfRows : \(movieTrailers.count)")
            numOfRows = movieTrailers.count
        } else {
            numOfRows = 4
        }
        
        return numOfRows!
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRow")
        let cell: UITableViewCell?
        
        if tableView == trailersTable {
            cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath)
            
            trailerName.text = "trailer"
            cell?.selectionStyle = .none
            cell?.addSubview(trailerName)

        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            if indexPath.row == 0 {
                
                movieTitleLbl.text = movieToShow.originalTitle
                //movieTitleLbl.bounds.width = screenWidth
                movieTitleLbl.intrinsicContentSize.width

                cell?.selectionStyle = .none
                cell?.backgroundColor = UIColor.gray
                cell?.addSubview(movieTitleLbl)
            }
            
            else if indexPath.row == 1 {
                
                //Poster
                moviePoster.sd_setImage(with: URL(string: movieToShow.poster), placeholderImage: UIImage(named: "default-image.png"))
                moviePoster.frame = CGRect(x: 16, y: 16, width: screenWidth/2, height: screenWidth/2 + 80)

                //ReleaseDate
                releaseDateLbl.font = releaseDateLbl.font.withSize(13)
                releaseDateLbl.text = String(movieToShow.releaseDate.split(separator: "-")[0])
                releaseDateLbl.frame = CGRect(x: 200 , y: movieTitleLbl.bounds.size.height, width: 40, height: 40)
                
                //FavoriteButton
                favParam.bigShineColor = UIColor(rgb: (153,152,38))
                favParam.smallShineColor = UIColor(rgb: (102,102,102))
                favBtnX = (cell?.frame.width)!-30
                favBtnY = (cell?.frame.height)!+30
                
                let favBtn = WCLShineButton(frame: .init(x: favBtnX, y: favBtnY, width: 25, height: 25), params: favParam)
                
                if movieToShow.addedToCoreData == false {
                    favBtn.fillColor = UIColor(rgb: (153,152,38))
                    favBtn.color = UIColor(rgb: (170,170,170))
                    
                } else {
                    favBtn.fillColor = UIColor(rgb: (170,170,170))
                    favBtn.color = UIColor(rgb: (153,152,38))
                }
                
                favBtn.addTarget(self, action: #selector(addMovieToFav), for: .valueChanged)
                
                cell?.selectionStyle = .none
                cell?.addSubview(moviePoster)
                cell?.addSubview(releaseDateLbl)
                cell?.addSubview(favBtn)
                
            }
            
            else if indexPath.row == 2 {
                synopsisLbl.font = synopsisLbl.font.withSize(13)
                synopsisLbl.text = movieToShow.synopsis
                synopsisLbl.numberOfLines = 0
                synopsisLbl.lineBreakMode = .byWordWrapping
                synopsisLbl.sizeToFit()
                
                /*let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
                label.numberOfLines = 0
                label.lineBreakMode = NSLineBreakMode.ByWordWrapping
                label.font = font
                label.text = text
                
                label.sizeToFit()
                return label.frame.height*/
                
                
                cell?.selectionStyle = .none
                cell?.addSubview(synopsisLbl)

            }
            
            else if indexPath.row == 3 {
                trailersTable.delegate = self
                trailersTable.dataSource = self
                trailersTable.register(UITableViewCell.self, forCellReuseIdentifier: "TrailerCell")
                cell?.addSubview(trailersTable)
                cell?.selectionStyle = .none
                
                connector.getMovieTrailers(movieId: movieToShow.id)
            }
            
        }
        
        return cell!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var cellHeight: CGFloat?
        
        if tableView == trailersTable {
            cellHeight = moviePoster.bounds.height
            
        } else {
            
            if indexPath.row == 0 {
                cellHeight = 88
                
            }
                
            else if indexPath.row == 1 {
                cellHeight = 260
            }
                
            else if indexPath.row == 2 {
                cellHeight = 100
                
            }
                
            else if indexPath.row == 3 {
                
                cellHeight = 400
            }
            
        }
        
        return cellHeight!
    }
    
}
