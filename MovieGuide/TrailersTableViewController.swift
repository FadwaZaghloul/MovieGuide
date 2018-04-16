//
//  TrailersTableController.swift
//  MovieGuide
//
//  Created by Fadwa Zaghloul on 4/13/18.
//  Copyright © 2018 ITI. All rights reserved.
//

import UIKit

class TrailersTableViewController: UITableViewController, TrailersDelegate {
    
    var movieTrailers: [String] = [String]()
    
    func setMovieTrailers(trailers: [String]) {
        movieTrailers = trailers
    }
    
    func reloadTrailersData() {
        print("reload")
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("TrailersDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("TrailersNumOfRows : \(movieTrailers.count)")
        return movieTrailers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("TrailersCell")

        let cell = tableView.dequeueReusableCell(withIdentifier: "TrailerCell", for: indexPath)

        (cell.viewWithTag(1) as! UILabel).text = "trailer"

        return cell
    }

}
